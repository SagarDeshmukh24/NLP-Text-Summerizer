FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    awscli \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .

# Upgrade pip
RUN pip install --upgrade pip

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install/upgrade required ML libraries
RUN pip install --no-cache-dir --upgrade transformers accelerate

# Copy project files
COPY . .

# Expose app port (optional but recommended)
EXPOSE 8080

# Run application
CMD ["python", "app.py"]