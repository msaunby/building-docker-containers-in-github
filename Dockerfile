# See https://hub.docker.com/r/tiangolo/uwsgi-nginx-flask/
FROM tiangolo/uwsgi-nginx-flask:python3.11

# Build args
ARG VERSION

# Working Directory
# WORKDIR /app

# Install packages from requirements.txt
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade pip &&\
    pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

# Copy source code to working directory
COPY ./app /app

# Default env vars
ENV PORT=80
ENV VERSION=$VERSION
