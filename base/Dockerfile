FROM nobodyxu/llvm-toolchain:stage1 AS previous_stage1
FROM debian:buster AS base

COPY --from=previous_stage1 /opt/llvm/src /opt/llvm/src

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
COPY detect-git-proxy.sh /tmp
RUN /tmp/detect-apt-proxy.sh ${APT_PROXY_HOST} ${APT_PROXY_PORT}

RUN apt-get update && apt-get dist-upgrade -y

# Install dependencies
RUN apt-get install -y --no-install-recommends \
                    build-essential perl cmake git curl apt-utils ca-certificates ninja-build \
                    python libncurses5-dev libedit-dev libpthread-stubs0-dev clang

# Add git proxy 
RUN /tmp/detect-git-proxy.sh ${GIT_PROXY_HOST} ${GIT_PROXY_PORT}

## Clone repository for auto building llvm
RUN cd /tmp/ && git clone https://github.com/NobodyXu/install-clang.git

COPY run_install_clang.sh /tmp/

# The command below does not clean the build tree. It only clones the llvm mirror.
RUN cd /tmp/ && env PATH=/opt/llvm/bin:$PATH ./run_install_clang.sh -D $([ -z `ls /opt/llvm/src` ] || echo "-c")

# Run stage 1 only.
RUN cd /tmp/ && ./run_install_clang.sh -c -O 1 -G Ninja
