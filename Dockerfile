FROM debian:sid-slim

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
  && mkdir -p /kyopro/include/ac-library \
  && mv atcoder /kyopro/include/ac-library/ \
  && rm ac-library.zip
ENV CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/kyopro/include/ac-library

# boost
RUN apt install -y libboost-all-dev

RUN git clone -b v2 https://github.com/ZOI-dayo/atcoder-library.git /kyopro/include/atcoder-library
ENV CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/kyopro/include/atcoder-library

RUN git clone https://github.com/philip82148/cpp-dump.git /kyopro/include/cpp-dump
ENV CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/kyopro/include/cpp-dump

# online-judge-tools
RUN apt install -y python3 python3-pip
RUN pip3 install --break-system-packages online-judge-tools

RUN apt install -y g++

RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/ZOI-dayo/cpp-bundler.git /tmp/cpp-bundler \
  && cd /tmp/cpp-bundler \
  && make build \
  && cp build/cpp-bundler /usr/local/bin/ \
  && rm -rf /tmp/cpp-bundler

RUN pip3 install --break-system-packages setuptools

COPY dotfiles /root
COPY src /kyopro
VOLUME /kyopro
WORKDIR /kyopro/tmp

