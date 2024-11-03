#i am reusing the layout from someone and tweaked it. i do not remember his name.
#sorry, friend.
FROM python:3.12-alpine
LABEL maintainer="devlemosjose@gmail.com"

COPY application /application
COPY scripts /scripts 

WORKDIR application

EXPOSE 8000


RUN python -m venv /venv && \
  /venv/bin/pip install --upgrade pip && \
  /venv/bin/pip install -r /application/requirements.txt && \
  adduser --disabled-password --no-create-home duser && \
  mkdir -p /data/web/static && \
  mkdir -p /data/web/media && \
  chown -R duser:duser /venv && \
  chown -R duser:duser /data/web/static && \
  chown -R duser:duser /data/web/media && \
  chmod -R 755 /data/web/static && \
  chmod -R 755 /data/web/media && \
  chmod -R +x /scripts


USER duser

ENV PATH="/scripts:/venv/bin:$PATH"


CMD ["land.sh"]
