FROM python:3.8

# Expose the application port
EXPOSE 1006

ARG APP_DIR

# Set the working directory
WORKDIR ${APP_DIR}

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx

# Copy application files
ADD ./requirements.txt ${APP_DIR}/requirements.txt

# Install Python packages
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Set the command to run the application
CMD ["python", "run.py"]
