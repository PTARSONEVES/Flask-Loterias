# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# Comentários são fornecidos ao longo deste arquivo para ajudá-lo a começar.
# Se precisar de mais ajuda, visite o guia de referência do Dockerfile em
# https://docs.docker.com/engine/reference/builder/

ARG PYTHON_VERSION=3.11.4
FROM python:${PYTHON_VERSION}-slim as base

# Prevents Python from writing pyc files.
# Impede que o Python grave arquivos pyc.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
# Impede que o Python armazene em buffer stdout e stderr para evitar situações em que
# o aplicativo trava sem emitir nenhum log devido ao buffer.
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Create a non-privileged user that the app will run under.
# Crie um usuário sem privilégios sob o qual o aplicativo será executado.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
#ARG UID=10001
#RUN adduser \
#    --disabled-password \
#   --gecos "" \
#   --home "/nonexistent" \
#    --shell "/sbin/nologin" \
#    --no-create-home \
#    --uid "${UID}" \
#    appuser

#RUN groupadd flaskpdf
#RUN usermod -G flaskpdf appuser
#RUN chmod 666 /app

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# into this layer.
# Baixe as dependências como uma etapa separada para aproveitar as vantagens do cache do Docker.
# Aproveite uma montagem de cache em /root/.cache/pip para acelerar compilações subsequentes.
# Aproveite uma montagem vinculada ao requirements.txt para evitar ter que copiá-los para
# nesta camada.
RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=requirements.txt,target=requirements.txt \
    python -m pip install -r requirements.txt

RUN apt-get update && apt-get install -y wkhtmltopdf xvfb

# Switch to the non-privileged user to run the application.
# Mude para o usuário sem privilégios para executar o aplicativo.
#USER appuser

# Copy the source code into the container.
# Copie o código-fonte para o contêiner.
COPY . .

# Expose the port that the application listens on.
# Exponha a porta que o aplicativo escuta.
EXPOSE 5000

# Run the application.
# Execute a aplicação
#CMD gunicorn '.venv.Lib.site-packages.gunicorn.http.wsgi' --bind=0.0.0.0:8000
CMD [ "flask", "--app", "flaskr", "run", "--host=0.0.0.0"]
#CMD flask --app flaskr run --host=0.0.0.0
