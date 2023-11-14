from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for,current_app
)
from werkzeug.exceptions import abort

from ..auth.auth import login_required
#from ...database.db import get_db
#from ...config import BaseConfig

bp = Blueprint('start',__name__)

@bp.route('/')
def home():
    nfan = current_app.config["NOME_FANTASIA"]
    return render_template('home.html',rsoc=nfan) 
