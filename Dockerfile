FROM debian:stable-slim

RUN apt update

# neovim
RUN apt install -y git
RUN apt install -y ninja-build cmake gettext curl
RUN cd /tmp \
  && git clone https://github.com/neovim/neovim.git \
  && cd neovim \
  && git checkout stable \
  && make CMAKE_BUILD_TYPE=Release \
  && make install \
  && rm -rf /tmp/neovim
RUN apt install -y nodejs # Copilot

# clang
RUN apt install -y clang-16
RUN apt install -y lldb
RUN apt install -y clangd

# ac-library
RUN apt install -y unzip
RUN cd /tmp \
  && curl -LO https://github.com/atcoder/ac-library/releases/download/v1.5.1/ac-library.zip \
  && unzip ac-library.zip \
  && mkdir -p /kyopro/include \
  && mv atcoder /kyopro/include/

RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN chsh -s /bin/bash

COPY dotfiles /root
COPY src /kyopro
VOLUME /kyopro
WORKDIR /kyopro

