FROM nobodyxu/llvm-toolchain:base AS stage1

# Run stage 2 only.
RUN cd /tmp/ && ./run_install_clang.sh -c -O 2 -G Ninja
