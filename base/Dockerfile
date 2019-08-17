FROM nobodyxu/llvm-toolchain:dev AS previous_dev
FROM debian:buster AS base

COPY --from=previous_dev /opt/llvm/src /opt/llvm/src

# Add apt cache
# This code is adapted from:
#     https://gist.github.com/dergachev/8441335#gistcomment-2007024
ENV DEBIAN_FRONTEND=noninteractive

## When installed using `apt install squid-deb-proxy`, it listens on port 8000 on the host by dfault.
## Override this variable with "" can disable apt proxy.
ARG APT_PROXY_PORT
ARG APT_PROXY_HOST
ARG GIT_PROXY_PORT
ARG GIT_PROXY_HOST

COPY detect-apt-proxy.sh /tmp
RUN /tmp/detect-apt-proxy.sh ${APT_PROXY_HOST} ${APT_PROXY_PORT} "" ""

RUN apt-get update && apt-get dist-upgrade -y

# Install basic softwares
RUN apt-get install -y --no-install-recommends build-essential perl cmake git curl apt-utils ca-certificates ninja-build

# Add git proxy 
RUN /tmp/detect-apt-proxy.sh "" "" ${GIT_PROXY_HOST} ${GIT_PROXY_PORT}

# Install llvm softwares
## First install dependencies for building clang
RUN apt-get install -y --no-install-recommends python libncurses5-dev libedit-dev libpthread-stubs0-dev

## Also clang for self lifting
RUN apt-get install -y --no-install-recommends clang

## Clone repository for auto building llvm
RUN cd /tmp/ && git clone https://github.com/NobodyXu/install-clang.git

COPY run_install_clang.sh /tmp/

# The command below does not clean the build tree. It only clones the llvm mirror.
RUN env PATH=/opt/llvm/bin:$PATH /tmp/run_install_clang.sh -D $([ -z `ls /opt/llvm/src` ] || echo "-c")

# Run stage 1 only.
RUN /tmp/run_install_clang.sh -c -O 1 -G Ninja
