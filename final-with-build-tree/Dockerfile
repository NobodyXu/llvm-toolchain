FROM nobodyxu/llvm-toolchain:stage1 AS stage1

ARG need_userns_workaround=false

# Workaround the problem that multi-stage build cannot copy files between stages when
# usernamespace is enabled.
RUN ${need_userns_workaround} && chown -R root:root /usr/bin /opt/llvm || echo true

FROM nobodyxu/llvm-toolchain:latest AS final-with-build-tree
COPY --from=stage1 /opt/llvm/src /opt/llvm/src
