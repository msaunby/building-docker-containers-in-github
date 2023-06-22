FROM tiangolo/meinheld-gunicorn-flask:python3.9

# See https://hub.docker.com/r/tiangolo/meinheld-gunicorn-flask/
# Note Python3.9 is used for compatibility. This image is actively
# maintained.

# Alternatively
# FROM tiangolo/uwsgi-nginx-flask:python3.11

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

# Use this CMD to only run the python app
#CMD pipenv run python /app/main.py
# Or this CMD if the requirements have been 'pip install'ed.
#CMD python /app/main.py