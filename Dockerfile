FROM debian:buster AS stage1

# Add apt cache
# This code is adapted from:
#     https://gist.github.com/dergachev/8441335#gistcomment-2007024
ENV DEBIAN_FRONTEND=noninteractive

## When installed using `apt install squid-deb-proxy`, it listens on port 8000 on the host by dfault.
## Override this variable with "" can disable apt proxy.
ARG APT_PROXY_PORT=8000
ARG GIT_PROXY_PORT=8080

COPY detect-apt-proxy.sh /root
RUN /root/detect-apt-proxy.sh ${APT_PROXY_PORT}

RUN apt-get update && apt-get dist-upgrade -y

# Install basic softwares
RUN apt-get install -y --no-install-recommends build-essential perl cmake git curl apt-utils

# Add git proxy 
RUN /root/detect-apt-proxy.sh "" ${GIT_PROXY_PORT}

# Install llvm softwares
## First install dependencies for building clang
RUN apt-get install -y --no-install-recommends python libncurses5-dev libedit-dev libpthread-stubs0-dev

## Also clang for self lifting
RUN apt-get install -y --no-install-recommends clang

## Clone repository for auto building llvm
RUN cd /tmp/ && git clone https://github.com/rsmmr/install-clang.git

COPY run_install_clang.sh /root/
# The command below does not clean the build tree.
RUN env PATH=/opt/llvm/bin:$PATH /root/run_install_clang.sh

# Workaround the problem that multi-stage build cannot copy files between stages when 
# usernamespace is enabled.
RUN chown -R root:root /opt/llvm

FROM debian:buster AS stage2-with-build-tree
COPY --from=stage1 /opt/llvm /opt/llvm
COPY install-alternatives.sh /tmp/
RUN /root/install-alternatives.sh

# Workaround the problem that multi-stage build cannot copy files between stages when
# usernamespace is enabled.
RUN chown -R root:root /usr/bin /opt/llvm

FROM debian:buster as final-with-src
COPY --from=stage2-with-build-tree / /
ENV PATH=/opt/llvm/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

FROM stage1 AS stage2-with-no-build-tree
RUN rm -r /opt/llvm/src
COPY install-alternatives.sh /tmp/
RUN /tmp/install-alternatives.sh
RUN rm /tmp/install-alternatives.sh

# Workaround the problem that multi-stage build cannot copy files between stages when
# usernamespace is enabled.
RUN chown -R root:root /usr/bin /opt/llvm

FROM debian:buster as final-no-build-tree
COPY --from=stage2-no-build-tree / /
ENV PATH=/opt/llvm/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
