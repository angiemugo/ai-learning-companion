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

## Data Flow

The system follows this data flow from user speech to email report:

1. **Audio Capture**: Flutter app captures child's speech via microphone
2. **LiveKit Streaming**: Audio streams in real-time to LiveKit cloud infrastructure  
3. **Agent Processing**: Python LiveKit agent receives audio stream
4. **Speech-to-Text**: Deepgram Nova-3 converts speech to text
5. **AI Processing**: OpenAI GPT-4o-mini processes text and generates contextual responses
6. **Text-to-Speech**: OpenAI TTS converts AI response back to speech
7. **Audio Response**: Speech streams back through LiveKit to Flutter app
8. **Session Tracking**: Backend tracks conversation flow, learning progress, and responses
9. **Report Generation**: At session end, system generates HTML progress report
10. **Email Delivery**: SMTP sends report to parent's email address provided during onboarding

```
Child Speech → Flutter → LiveKit → Python Agent → Deepgram → GPT-4o → TTS → LiveKit → Flutter
                                         ↓
                               Session Data Storage → Report Generation → Email
```

## Trade-offs & Limitations

### Design Trade-offs Made:
- **LiveKit Sandbox vs Production**: Used sandbox for simplicity, limiting scalability
- **OpenAI vs Local Models**: Chose OpenAI for reliability over cost-effectiveness of local LLMs
- **Synchronous Email**: Email sending blocks session end vs async background processing
- **Single Topic**: Focused on primary colors rather than dynamic topic selection
- **Flutter vs React Native**: Chose Flutter for LiveKit integration ease

### Current Limitations:
- **Session Persistence**: No database storage - sessions lost on restart
- **Error Recovery**: Limited handling of network disconnections or API failures  
- **Scalability**: Sandbox limits concurrent users and session duration
- **Security**: No authentication system or input validation
- **Accessibility**: No support for hearing-impaired or non-English speakers
- **Content**: Single learning topic limits educational scope

### Future Improvements:
- Add PostgreSQL for session persistence and analytics
- Implement robust error handling and connection retry logic
- Upgrade to production LiveKit with auto-scaling
- Add user authentication and progress tracking across sessions
- Support multiple languages and accessibility features
- Dynamic topic selection based on child's age/interests

## How I used AI 
- **System Design**: AI helped design the LiveKit agent backend and Flutter frontend architecture
- **Agent Framework**: Understanding LiveKit agent system with proper event handling
- **WebRTC Integration**: LiveKit client setup, room management, and audio streaming
- **Ello Character**: Crafted AI tutor personality and age-appropriate conversation style
- **Problem Solving**: Resolved integration issues, audio permissions, and cross-platform bugs
