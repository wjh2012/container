FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04

ENV TZ=Asia/Seoul \
    DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

RUN apt-get update && \
    apt-get install -y python3-pip python3-dev python-is-python3 pkg-config tzdata libgl1-mesa-glx && \
    rm -rf /var/lib/apt/lists/*
