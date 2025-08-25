import logging
import asyncio

from dotenv import load_dotenv
from livekit import agents
from livekit.agents import AgentSession, Agent, RoomInputOptions, UserStateChangedEvent, AgentStateChangedEvent
from livekit.plugins import deepgram, noise_cancellation, silero, openai
from livekit.plugins.turn_detector.multilingual import MultilingualModel
from livekit.agents.voice.events import CloseEvent, ErrorEvent
from prompts import AGENT_INSTRUCTION, SESSION_INSTRUCTION, SILENCE_INSTRUCTION
from actions import SessionData, send_progress_email

load_dotenv()
logger = logging.getLogger("agent")

class Assistant(Agent):
    def __init__(self) -> None:
        super().__init__(instructions=AGENT_INSTRUCTION)
        self.session_data = SessionData()

async def entrypoint(ctx: agents.JobContext):
    session_data = SessionData()
    session = AgentSession(
        stt=deepgram.STT(model="nova-3", language="multi"),
        llm=openai.LLM(model="gpt-4o-mini"),
        tts=openai.TTS(),
        vad=silero.VAD.load(),
        turn_detection=MultilingualModel(),
    )
    
    # --- Event handlers ---
    @session.on("user_state_changed")
    def on_user_state_changed(ev: UserStateChangedEvent):
        messages = {
            "speaking": "User started speaking",
            "listening": "User stopped speaking",
            "away": "User is away - generating proactive response",
        }
        msg = messages.get(ev.new_state)
        logger.info(f"New state received: {msg}")
        if ev.new_state == "away":
            session.generate_reply(user_input="", instructions=SILENCE_INSTRUCTION)

    @session.on("agent_state_changed")
    def on_agent_state_changed(ev: AgentStateChangedEvent):
        messages = {
            "initializing": "Agent is starting up",
            "idle": "Agent is ready",
            "listening": "Listening for user input",
            "thinking": "Processing your input...",
            "speaking": "Agent is responding",
        }
        msg = messages.get(ev.new_state)
        if msg:
            logger.info(msg)

    @session.on("close")
    def on_close(_: CloseEvent):
        logger.info("Session is closing")
        asyncio.create_task(send_progress_email(session_data))

    @session.on("error")
    def on_error(ev: ErrorEvent):
        if ev.error.recoverable:
            return

        logger.info(f"session is closing due to unrecoverable error {ev.error}")

    # --- Start session ---
    assistant = Assistant()
    assistant.session_data = session_data
    await session.start(
        room=ctx.room,
        agent=assistant,
        room_input_options=RoomInputOptions(
            noise_cancellation=noise_cancellation.BVC(),
        ),
    )

    await ctx.connect()
    await session.generate_reply(user_input="", instructions=SESSION_INSTRUCTION)

if __name__ == "__main__":
    agents.cli.run_app(agents.WorkerOptions(entrypoint_fnc=entrypoint))
