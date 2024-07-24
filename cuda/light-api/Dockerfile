FROM nvidia/cuda:12.5.1-runtime-ubuntu22.04

# Expose the application port
EXPOSE 5000

ARG APP_DIR

# Set the working directory
WORKDIR ${APP_DIR}

RUN apt-get update && \
    apt-get install -y python3-pip python3-dev python-is-python3 && \
    rm -rf /var/lib/apt/lists/*

# Copy application files
ADD ./requirements.txt ${APP_DIR}/requirements.txt

RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Set the command to run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
