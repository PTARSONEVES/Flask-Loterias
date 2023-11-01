import os
from flask import Flask
from . import config
from dotenv import load_dotenv
from .config import BaseConfig

load_dotenv()

def create_app(test_config=None):
    #cria e configura o app
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY=os.getenv('SECRET_KEY'),
        SECURITY_PASSWORD_SALT=os.getenv('SECURITY_PASSWORD_SALT'),
        DATABASE=os.path.join(app.instance_path, 'flask.sqlite'),
        # Configuração de email
        MAIL_SERVER=os.getenv('MAIL_SERVER'),
        MAIL_PORT=os.getenv('MAIL_PORT'),
        MAIL_USE_TLS=os.getenv('MAIL_USE_TLS'),
        MAIL_USE_SSL=os.getenv('MAIL_USE_SSL'),
        MAIL_USERNAME=os.getenv('MAIL_USERNAME'),
        MAIL_PASSWORD=os.getenv('MAIL_PASSWORD'),
        MAIL_DEFAULT_SENDER=os.getenv('MAIL_USERNAME')
    )

    SECRET_KEY = os.getenv('SECRET_KEY')
    print('NOME FANTASIA: ',os.getenv('EMPRESA_NOMFAN'))

    from .controller.auth import auth
    app.register_blueprint(auth.bp)

    from .controller.start import start
    app.register_blueprint(start.bp)

    from .controller.blog import blog
    app.register_blueprint(blog.bp)

    from .controller.pdf import pdf
    app.register_blueprint(pdf.bp)

    if test_config is None:
        #Carrega a instância config, se ela existir, então não testa
        app.config.from_pyfile('config.py', silent=True)
    else:
        #Senão, carrega a estrutura de teste
        app.config.from_mapping(test_config)

    #Verifica se a pasta da instância existe
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    #Cria uma simples página
    @app.route('/hello')
    def hello():
        return 'Hello, World'

    app.add_url_rule('/', endpoint='home')
    app.add_url_rule('/register', endpoint='register')
#    app.add_url_rule('/', endpoint='index')

    return app