FROM python:3.8

# Expose the application port
EXPOSE 1006

# Set the working directory
WORKDIR /app

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx

# Copy application files
ADD ./requirements.txt /app/requirements.txt

# Install Python packages
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Set the command to run the application
CMD ["python", "run.py"]
