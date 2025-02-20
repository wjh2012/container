FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

EXPOSE 22

RUN apt-get update && \
    apt-get install -y pkg-config gcc tzdata net-tools openssh-server && \
    rm -rf /var/lib/apt/lists/*

# SSH 설정 수정
RUN sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 루트 패스워드를 'root'로 설정
RUN echo 'root:root' | chpasswd

# SSH 포트 개방
EXPOSE 22

# SSH 서비스를 시작하도록 설정
CMD service ssh start && python -m http.server