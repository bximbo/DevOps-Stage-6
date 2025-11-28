FROM python:3.11-slim

WORKDIR /app

# Update package index and install build dependencies
RUN apt-get update && apt-get install -y gcc build-essential python3-dev && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

EXPOSE 5000

# Run the application
CMD ["python", "main.py"]
