FROM base AS stage1

# Run stage 2 only.
RUN /tmp/install-clang/install-clang -c -O 2 /opt/llvm

# Workaround the problem that multi-stage build cannot copy files between stages when
# usernamespace is enabled.
RUN chown -R root:root /opt/llvm/src
