# Base Image
FROM python:3.11-slim-bullseye

# Working Directory
WORKDIR /app

# Install packages from requirements.txt
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip &&\
    pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

# Copy source code to working directory
COPY flaskserver ./flaskserver

# Default env vars and command.
ENV PORT=5000
CMD ["python", "flaskserver"]
