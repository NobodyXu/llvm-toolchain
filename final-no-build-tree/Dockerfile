FROM nobodyxu/llvm-toolchain:stage1 AS stage2-no-build-tree

# Install symbolic links by update-alternatives
COPY install-alternatives.sh /tmp/
RUN /tmp/install-alternatives.sh

# Remove build tree
RUN rm -r /opt/llvm/src

# Remove all installed softwares
RUN apt-get purge -y build-essential perl cmake git curl apt-utils python libncurses5-dev libedit-dev libpthread-stubs0-dev clang \
                     ca-certificates
RUN apt-get autoremove -y

# Remove all proxy
COPY remove-proxy.sh /tmp/

# Remove all scripts and apt-get cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Workaround the problem that multi-stage build cannot copy files between stages when
# usernamespace is enabled.
RUN chown -R root:root /usr/bin /opt/llvm

FROM debian:buster as final-no-build-tree
COPY --from=stage2-no-build-tree / /
ENV PATH=/opt/llvm/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
