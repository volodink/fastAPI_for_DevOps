# Use a lightweight base image
FROM tiangolo/uvicorn-gunicorn-fastapi:python3.10-slim as base

# Copy only necessary files
COPY requirements.txt ./

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY ./ ./

# Create and activate virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Set environment variables
ENV APP_MODULE=main:app
ENV PORT=5000

# Use a non-root user
USER 1000

# Start the application
CMD ["uvicorn", "--host", "0.0.0.0", "--port", "5000", "main:app"]

