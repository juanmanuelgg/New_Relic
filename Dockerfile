FROM python:3.13-slim

WORKDIR /app
COPY src /app/src

RUN pip3 install -r src/requirements.txt

ARG APP_PORT
ENV PORT=${APP_PORT:-5001}
EXPOSE $PORT

# Confguración New Relic
RUN pip3 install newrelic
ENV NEW_RELIC_APP_NAME="heroes-flask-app"
ENV NEW_RELIC_LOG=stdout
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
ENV NEW_RELIC_LOG_LEVEL=info
# INGEST_License
ENV NEW_RELIC_LICENSE_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

ENTRYPOINT ["newrelic-admin", "run-program", "python3", "src/application.py"]