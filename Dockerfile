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

RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN chsh -s /usr/bin/zsh

COPY dotfiles /root
COPY src /kyopro
VOLUME /kyopro
WORKDIR /kyopro

