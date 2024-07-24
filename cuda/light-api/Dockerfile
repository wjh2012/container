FROM nvidia/cuda:12.5.1-runtime-ubuntu22.04

# Expose the application port
EXPOSE 5000

# Set the working directory
WORKDIR /app

RUN apt-get update && \
    apt-get install -y python3-pip python3-dev python-is-python3 && \
    rm -rf /var/lib/apt/lists/*

# Copy application files
ADD ./requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Set the command to run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
