FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    awscli \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy all project files first
COPY . .

# Upgrade pip
RUN pip install --upgrade pip

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Upgrade ML libraries
RUN pip install --no-cache-dir --upgrade transformers accelerate

EXPOSE 8080

CMD ["python", "app.py"]