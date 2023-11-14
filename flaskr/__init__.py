import os
from flask import Flask
from config import BaseConfig,Download_FOLDER
#from .config import BaseConfig
from dotenv import load_dotenv
#from config import BaseConfig

load_dotenv()

def create_app(test_config=None):
    #cria e configura o app
    app = Flask(__name__,instance_relative_config=True)
    app.config.from_mapping(
        # Diretorios
        BASEDIR = os.path.abspath(os.path.dirname(__file__)),
        APP_ROOT = os.path.dirname(os.path.abspath(__file__)),
        DATABASE=os.path.join(app.instance_path, 'flask.sqlite'),
        DOWNLOAD_PATH = os.path.dirname(os.path.abspath(__file__))+'/wkhtmltopdf/bin/wkhtmltopdf.exe',

        #SECRET_KEY=os.getenv('SECRET_KEY'),
        #SECURITY_PASSWORD_SALT=os.getenv('SECURITY_PASSWORD_SALT'),
        SECRET_KEY=BaseConfig.SECRET_KEY,
        SECURITY_PASSWORD_SALT=BaseConfig.SECURITY_PASSWORD_SALT,


        # Configuração de email
        #MAIL_SERVER=os.getenv('MAIL_SERVER'),
        #MAIL_PORT=os.getenv('MAIL_PORT'),
        #MAIL_USE_TLS=os.getenv('MAIL_USE_TLS'),
        #MAIL_USE_SSL=os.getenv('MAIL_USE_SSL'),
        #MAIL_USERNAME=os.getenv('MAIL_USERNAME'),
        #MAIL_PASSWORD=os.getenv('MAIL_PASSWORD'),
        #MAIL_DEFAULT_SENDER=os.getenv('MAIL_USERNAME'),
        MAIL_SERVER=BaseConfig.MAIL_SERVER,
        MAIL_PORT=BaseConfig.MAIL_PORT,
        MAIL_USE_TLS=BaseConfig.MAIL_USE_TLS,
        MAIL_USE_SSL=BaseConfig.MAIL_USE_SSL,
        MAIL_USERNAME=BaseConfig.MAIL_USERNAME,
        MAIL_PASSWORD=BaseConfig.MAIL_PASSWORD,
        MAIL_DEFAULT_SENDER=BaseConfig.MAIL_USERNAME,
        # Dados da Empresa
        RAZAO_SOCIAL=BaseConfig.EMPRESA_RSOC,
        NOME_FANTASIA=BaseConfig.EMPRESA_NOMFAN
    )

    if test_config is None:
        #Carrega a instância config, se ela existir, então não testa
        app.config.from_pyfile('config.py',silent=True)
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


    print('SSS:',BaseConfig.EMPRESA_RSOC)
#    print(app.config.items())

    from .database import db
    db.init_app(app)
    db.atualiza_lf_app(app)

    from .controller.auth import auth
    app.register_blueprint(auth.bp)

    from .controller.start import start
    app.register_blueprint(start.bp)

    from .controller.blog import blog
    app.register_blueprint(blog.bp)

    from .controller.pdf import pdf
    app.register_blueprint(pdf.bp)

    app.add_url_rule('/', endpoint='home')
    app.add_url_rule('/register', endpoint='register')
#    app.add_url_rule('/', endpoint='index')

    return app