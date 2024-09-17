FROM python:3.12-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y firefox-esr wget && \
    wget https://github.com/mozilla/geckodriver/releases/download/v0.32.1/geckodriver-v0.32.1-linux64.tar.gz && \
    tar -xzf geckodriver-v0.32.1-linux64.tar.gz && \
    mv geckodriver /usr/local/bin/ && \
    rm geckodriver-v0.32.1-linux64.tar.gz

# Set working directory
WORKDIR /app

# Copy application files
COPY . .

# Ensure geckodriver has the correct permissions
RUN chmod +x /usr/local/bin/geckodriver

# Install Python dependencies
RUN pip install -r requirements.txt

# Run your application
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:create_app()"]
