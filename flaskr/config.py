import os
from dotenv import load_dotenv 

load_dotenv()

Download_PATH = 'wkhtmltopdf/bin/wkhtmltopdf.exe'
basedir = os.path.abspath(os.path.dirname(__file__))
APP_ROOT = os.path.dirname(os.path.abspath(__file__))
Download_FOLDER = os.path.join(APP_ROOT, Download_PATH)



class BaseConfig(object):
    """Base configuration."""
    #DADOS DA EMPRESA
    EMPRESA_RSOC = os.getenv('EMPRESA_RSOC')
    EMPRESA_NOMFAN = os.getenv('EMPRESA_NOMFAN')
    EMPRESA_LOGRADOURO = os.getenv('EMPRESA_LOGRADOURO')
    EMPRESA_NUMLOGR = os.getenv('EMPRESA_NUMLOGR')
    EMPRESA_COMPLEMENTO = os.getenv('EMPRESA_COMPLEMENTO')
    EMPRESA_BAIRRO = os.getenv('EMPRESA_BAIRRO')
    EMPRESA_CODMUN = os.getenv('EMPRESA_CODMUN')
    EMPRESA_CODUF = os.getenv('EMPRESA_CODUF')
    EMPRESA_CODPAIS = os.getenv('EMPRESA_CODPAIS')
    #CONFIDENCIAL
    SECRET_KEY = os.getenv('SECRET_KEY')
    SECURITY_PASSWORD_SALT = os.getenv('SECURITY_PASSWORD_SALT')
    DEBUG = False
    BCRYPT_LOG_ROUNDS = 13
    WTF_CSRF_ENABLED = True
    DEBUG_TB_ENABLED = False
    DEBUG_TB_INTERCEPT_REDIRECTS = False
    #BANCO DE DADOS
    TYPE_CONNECT = os.getenv('TYPE_CONNECT')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    #SQLITE - LOCALHOST
    SQLITE_CONNECT = 'sqlite:///' + os.path.join(basedir, 'dev.sqlite')
    #CORRESPONDENCIA

class DevelopmentConfig(BaseConfig):
    """Development configuration."""
    DEBUG = True
    WTF_CSRF_ENABLED = False
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'dev.sqlite')
    DEBUG_TB_ENABLED = True


class TestingConfig(BaseConfig):
    """Testing configuration."""
    TESTING = True
    DEBUG = True
    BCRYPT_LOG_ROUNDS = 1
    WTF_CSRF_ENABLED = False
    SQLALCHEMY_DATABASE_URI = 'sqlite://'


class ProductionConfig(BaseConfig):
    """Production configuration."""
    SECRET_KEY = 'my_precious'
    DEBUG = False
    SQLALCHEMY_DATABASE_URI = 'postgresql://localhost/example'
    DEBUG_TB_ENABLED = False
    STRIPE_SECRET_KEY = 'foo'
    STRIPE_PUBLISHABLE_KEY = 'bar'