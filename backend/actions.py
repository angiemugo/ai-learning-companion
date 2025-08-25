import os
import logging
import smtplib
import ssl
from datetime import datetime
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

logger = logging.getLogger("agent")

class SessionData:
    def __init__(self):
        self.child_name = ""
        self.topic_covered = ""
        self.questions_and_answers = []
        self.start_time = datetime.now()
        self.parent_email = ""
        self.understanding_level = "Good"

    def add_interaction(self, question, answer):
        self.questions_and_answers.append({"question": question, "answer": answer})


async def send_progress_email(session_data: SessionData):
    try:
        # Email configuration from environment variables
        smtp_server = os.getenv('SMTP_SERVER', 'smtp.gmail.com')
        smtp_port = int(os.getenv('SMTP_PORT', '587'))
        sender_email = os.getenv('MAIL_USERNAME')
        sender_password = os.getenv('MAIL_PASSWORD')

        if not sender_email or not sender_password:
            error_msg = "Email configuration missing: MAIL_USERNAME and MAIL_PASSWORD required"
            logger.error(error_msg)
            return False

        if not session_data.parent_email:
            error_msg = "Parent email not provided"
            logger.error(error_msg)
            return False

        # Create message
        message = MIMEMultipart("alternative")
        message["Subject"] = f"Learning Progress Report - {session_data.child_name or 'Your Child'}"
        message["From"] = "some@gmail.com" #this is an error, we should get the error from a session_data
        message["To"] = session_data.parent_email

        # Create email content
        session_duration = datetime.now() - session_data.start_time
        duration_minutes = round(session_duration.total_seconds() / 60, 1)

        html_content = f"""
        <html>
          <body>
            <h2>🎓 Learning Session Report</h2>
            <p>Dear Parent,</p>

            <p>Here's how <strong>{session_data.child_name or 'your child'}</strong> did in today's learning session with Ello:</p>

            <h3>📋 Session Summary</h3>
            <ul>
                <li><strong>Child's Name:</strong> {session_data.child_name or 'Not provided'}</li>
                <li><strong>Session Date:</strong> {session_data.start_time.strftime('%B %d, %Y at %I:%M %p')}</li>
                <li><strong>Duration:</strong> {duration_minutes} minutes</li>
                <li><strong>Topic Covered:</strong> {session_data.topic_covered or 'Various topics'}</li>
                <li><strong>Overall Understanding:</strong> {session_data.understanding_level}</li>
            </ul>

            <h3>💬 Questions & Responses</h3>
        """

        if session_data.questions_and_answers:
            for i, qa in enumerate(session_data.questions_and_answers, 1):
                html_content += f"<p><strong>Q{i}:</strong> {qa['question']}<br><strong>Answer:</strong> {qa['answer']}</p>"
        else:
            html_content += "<p>No specific Q&A recorded during this session.</p>"

        html_content += f"""
            <h3>🌟 Notes</h3>
            <p>{session_data.child_name or 'Your child'} participated well in today's learning session! 
            Ello enjoyed teaching them about {session_data.topic_covered or 'various educational topics'}.</p>

            <p>Keep up the great work encouraging their curiosity and love for learning!</p>

            <p>Best regards,<br>
            <strong>Ello - AI Learning Companion</strong></p>

            <hr>
            <small>This is an automated report from your child's learning session.</small>
          </body>
        </html>
        """

        # Create HTML part
        html_part = MIMEText(html_content, "html")
        message.attach(html_part)

        # Send email
        context = ssl.create_default_context()
        with smtplib.SMTP(smtp_server, smtp_port) as server:
            server.starttls(context=context)
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, session_data.parent_email, message.as_string())

        logger.info(f"Progress email sent successfully to {session_data.parent_email}")
        return True

    except Exception as e:
        error_msg = f"Failed to send progress email: {e}"
        logger.error(error_msg)
