# Use official Python image with build tools
FROM python:3.11-bullseye

WORKDIR /app

# Install OpenCV dependencies in a single layer
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application
COPY main.py .

# Use dynamic port
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}
