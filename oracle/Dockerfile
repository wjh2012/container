FROM oraclelinux:8.10

ENV NODE_VERSION=18
ENV NVM_DIR=/root/.nvm
ENV PATH="$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH"

# nvm 및 node 설치
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && \
    bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION && npm install -g pm2" && \
    ln -s $NVM_DIR/versions/node/v$NODE_VERSION/bin/node /usr/bin/node && \
    ln -s $NVM_DIR/versions/node/v$NODE_VERSION/bin/npm /usr/bin/npm && \
    ln -s $NVM_DIR/versions/node/v$NODE_VERSION/bin/pm2 /usr/bin/pm2

WORKDIR /workspace

# pm2 실행 및 bash 진입
CMD ["bash", "-c", "cd dnihtml-pdf-server && ./pm2Start.sh && bash"]
