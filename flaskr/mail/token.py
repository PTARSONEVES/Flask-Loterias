import os
from itsdangerous import URLSafeTimedSerializer
from dotenv import load_dotenv

load_dotenv()

def generate_confirmation_token(email):
    serializer = URLSafeTimedSerializer(os.getenv('SECRET_KEY'))
    return serializer.dumps(email, salt=os.getenv('SECURITY_PASSWORD_SALT'))

def confirm_token(token, expiration=360000):
    serializer = URLSafeTimedSerializer(os.getenv('SECRET_KEY'))
    salt = os.getenv('SECURITY_PASSWORD_SALT')
    try:
        email = serializer.loads(
            token,
            salt=salt,
            max_age=expiration
        )
    except:
        return False
    return email