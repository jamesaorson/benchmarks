FROM mcr.microsoft.com/devcontainers/base:jammy

RUN sudo apt-get update && \
    apt-get install -y \
    build-essential \
    libssl-dev \
    curl \
    file \
    git

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

RUN brew install go
RUN brew install borkdude/brew/babashka
