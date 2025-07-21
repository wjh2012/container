FROM oraclelinux:8.10

ENV NODE_VERSION=18
ENV NVM_DIR=/root/.nvm

# nvm 설치 및 node 설치
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && \
    bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION"

WORKDIR /workspace

# bash로 컨테이너 진입
CMD [ "bash" ]
