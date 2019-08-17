FROM nobodyxu/llvm-toolchain:stage1 AS stage1
# Workaround the problem that multi-stage build cannot copy files between stages when
# usernamespace is enabled.
RUN chown -R root:root /opt/llvm/src

FROM nobodyxu/llvm-toolchain:latest AS final-with-build-tree
COPY --from=stage1 /opt/llvm/src /opt/llvm/src
