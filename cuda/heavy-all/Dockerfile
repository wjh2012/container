FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04

ARG APP_DIR

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

EXPOSE 1004

WORKDIR ${APP_DIR}

ADD ./requirements.txt ${APP_DIR}/requirements.txt

RUN apt-get update && \
    apt-get install -y \
    wget \
    build-essential \
    python3.8 \
    python3.8-dev \
    python3.8-distutils \
    python3-pip \
    python-is-python3 \
    pkg-config \
    libmysqlclient-dev \
    tzdata \
    imagemagick \
    libgl1-mesa-glx

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
