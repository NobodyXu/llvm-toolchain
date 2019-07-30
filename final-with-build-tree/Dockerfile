FROM nobodyxu/llvm-toolchain:stage1 AS stage1
FROM nobodyxu/llvm-toolchain:latest AS final-with-build-tree
COPY --from=stage1 /opt/llvm/src /opt/llvm/src
