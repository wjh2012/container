FROM nvidia/cuda:12.0.0-cudnn8-runtime-ubuntu20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Expose the application port
EXPOSE 1004

ARG APP_DIR

# Set the working directory
WORKDIR ${APP_DIR}

# Copy application files
ADD ./requirements.txt ${APP_DIR}/requirements.txt

# Install necessary tools and dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    build-essential \
    pkg-config \
    python3.8 \
    python3.8-dev \
    python3.8-distutils \
    libmysqlclient-dev \
    libgl1-mesa-glx \
    imagemagick

# Install pip for Python 3.8
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3.8 get-pip.py && \
    rm get-pip.py

# Create symbolic links to ensure 'python3' and 'pip3' use Python 3.8
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
    update-alternatives --install /usr/bin/pip3 pip3 /usr/local/bin/pip3 1

# Install Python packages
RUN pip3 install -r requirements.txt

# Set the command to run the application
CMD ["python3", "run.py"]