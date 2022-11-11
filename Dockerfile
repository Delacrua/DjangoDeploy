FROM python:3.10.8-alpine
LABEL maintainer='ufiodarau@gmail.com'

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./src /src

WORKDIR /src
EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
    build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home defaultuser && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R app: app /vol && \
    chmod -R 755 /vol

ENV PATH="/py/bin:$PATH"

USER defaultuser