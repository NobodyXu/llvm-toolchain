FROM nobodyxu/llvm-toolchain:stage1 AS stage1

COPY shallow_clone.sh /tmp/
RUN /tmp/shallow_clone.sh

ARG need_userns_workaround=false

# Workaround the problem that multi-stage build cannot copy files between stages when
# usernamespace is enabled.
RUN ${need_userns_workaround} && chown -R root:root /root/llvm || echo true

FROM nobodyxu/llvm-toolchain:latest AS final-with-build-tree
COPY --from=stage1 /root/llvm/src /opt/llvm/src
