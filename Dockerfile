FROM python:3.11-slim

WORKDIR /app

# Install system dependencies - CORRECT package name (L-G-L-1, not L-G-1-1)
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY main.py .

# Use PORT environment variable from Render
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000} --workers 2
