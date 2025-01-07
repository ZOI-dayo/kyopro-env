FROM ubuntu:22.10

RUN sed -i -e 's/ports.ubuntu.com\/ubuntu-ports/old-releases.ubuntu.com\/ubuntu/g' /etc/apt/sources.list \
    && apt update

# --- compiler ---
RUN apt install unzip
# C++ 23 (Clang)
RUN cd /tmp \
    && apt install -y lsb-release wget software-properties-common gnupg \
    && wget https://apt.llvm.org/llvm.sh -O llvm.sh \
    && sed -i.bak -e 's/^add-apt-repository /&-y /' llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 16 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-16 10 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-16 10 \
    && mkdir /opt/ac-library \
    && wget https://github.com/atcoder/ac-library/releases/download/v1.5.1/ac-library.zip -O ac-library.zip \
    && unzip ac-library.zip -d /opt/ac-library \
    && wget https://archives.boost.io/release/1.82.0/source/boost_1_82_0.tar.gz -O boost_1_82_0.tar.gz \
    && tar xf boost_1_82_0.tar.gz \
    && cd boost_1_82_0 \
    && ./bootstrap.sh --with-toolset=clang --without-libraries=mpi,graph_parallel \
    && ./b2 -j3 toolset=clang variant=release link=static runtime-link=static cxxflags="-std=c++2b" stage \
    && ./b2 -j3 toolset=clang variant=release link=static runtime-link=static cxxflags="-std=c++2b" --prefix=/opt/boost/clang install \
    && cd /tmp \
    && apt install -y libgmp3-dev \
    && apt install -y libeigen3-dev \
    && apt install -y libz3-4 libz3-dev \
    && apt install -y gdb libbz2-dev liblzma-dev libsqlite3-dev libssl-dev lzma lzma-dev zlib1g-dev liblz4-dev liblzo2-dev
RUN apt install -y git
RUN mkdir /kyopro-lib
RUN git clone -b v2 https://github.com/ZOI-dayo/atcoder-library.git /kyopro-lib/atcoder-library
ENV CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/kyopro-lib/atcoder-library
RUN git clone https://github.com/philip82148/cpp-dump.git /kyopro-lib/cpp-dump
ENV CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/kyopro-lib/cpp-dump

RUN apt install -y clangd lldb


# --- neovim ---
RUN cd /tmp \
  && git clone https://github.com/neovim/neovim.git \
  && cd neovim \
  && git checkout stable \
  && apt install -y ninja-build gettext cmake unzip curl build-essential \
  && make CMAKE_BUILD_TYPE=Release \
  && make install \
  && rm -rf /tmp/neovim
RUN apt install -y nodejs # Copilot

# online-judge-tools
RUN apt install -y python3 python3-pip
RUN pip3 install online-judge-tools

RUN apt install -y bash-completion

RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN echo $CPLUS_INCLUDE_PATH
RUN git clone https://github.com/ZOI-dayo/cpp-bundler.git /tmp/cpp-bundler \
  && cd /tmp/cpp-bundler \
  && make build \
  && install /tmp/cpp-bundler/build/cpp-bundler /usr/local/bin

WORKDIR /kyopro

