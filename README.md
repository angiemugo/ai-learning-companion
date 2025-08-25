# AI Learning Companion for Kids

Interactive AI voice tutor for children using LiveKit agent backend and Flutter frontend.

## Features
- Real-time voice interaction with AI tutor "Ello"
- Primary colors learning sessions (5-10 minutes)
- Automated progress reports emailed to parents
- Cross-platform Flutter mobile app

## Quick Start

**Prerequisites:** Python 3.8+, Flutter SDK, OpenAI API key, LiveKit account

### Backend Setup
```bash
cd backend
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt
```

Create `.env` file:
```env
OPENAI_API_KEY=your_key
LIVEKIT_API_KEY=your_key  
LIVEKIT_API_SECRET=your_secret
LIVEKIT_URL=wss://your-server.livekit.cloud
MAIL_USERNAME=your_email@gmail.com
MAIL_PASSWORD=your_app_password
```

Run agent: `python app.py`

### Frontend Setup
```bash
cd frontend/learning_companion_app
flutter pub get
```

Create `.env` file:
```env
LIVEKIT_SANDBOX_ID=your_sandbox_id
```

Run app: `flutter run`

## Architecture

### Backend (LiveKit AI Agent)
- **OpenAI GPT-4o-mini** for conversation
- **Deepgram Nova-3** for speech-to-text  
- **OpenAI TTS** for voice responses
- **Session tracking** and email reporting
- **Ello AI personality** with 4-level silence management

### Frontend (Flutter)
- **Riverpod** state management
- **LiveKit client** for real-time audio
- **Material Design** kid-friendly UI
- **Session lifecycle** management

## Key Files

**Backend:**
- `app.py` - Main LiveKit agent entry point
- `prompts.py` - Ello's AI personality and conversation structure
- `actions.py` - Session data tracking and email reports

**Frontend:**
- `learning_session_controller.dart` - Riverpod session state management
- `session_service.dart` - LiveKit API integration
- `learning_session_screen.dart` - Main UI with voice controls

## AI System Details

### Ello AI Personality
- Cheerful tutor for 6-year-olds with warm, playful tone
- 4-phase session: Greeting → Lesson → Check → Wrap-up
- 4-level silence management system
- Handles creative responses and child questions naturally

### Session Flow
1. Child enters name/email → LiveKit room created
2. Ello greets child → Primary colors lesson (5-10 min)  
3. Q&A evaluation → Session ends with encouragement
4. HTML progress report emailed to parent

## API Setup

**OpenAI:** Get API key from [openai.com](https://openai.com)  
**LiveKit:** Get keys from [livekit.io](https://livekit.io) (free tier)  
**Gmail:** Enable 2FA, generate app password for SMTP


## Troubleshooting
- **Connection fails:** Check agent is running, verify API keys
- **No speech:** Check microphone permissions  
- **Email issues:** Verify Gmail app password in `.env`

## How I used AI 
- **System Design**: AI helped design the LiveKit agent backend and Flutter frontend architecture
- **Agent Framework**: Understanding LiveKit agent system with proper event handling
- **WebRTC Integration**: LiveKit client setup, room management, and audio streaming
- **Ello Character**: Crafted AI tutor personality and age-appropriate conversation style
- **Problem Solving**: Resolved integration issues, audio permissions, and cross-platform bugs
