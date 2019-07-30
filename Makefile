.PHONY: build no-build-tree with-build-tree stage1 base run
build: with-build-tree

base:
	docker build base --tag="nobodyxu/llvm-toolchain:base"

stage1: base
	docker build stage1 --tag="nobodyxu/llvm-toolchain:stage1"

no-build-tree: stage1
	docker build final-no-build-tree --tag="nobodyxu/llvm-toolchain:latest" \
	               $(${NO_APT_PROXY} && echo "--build-arg APT_PROXY_PORT=''") \
		       $(${NO_GIT_PROXY} && echo "--build-arg GIT_PROXY_PORT=''")

with-build-tree: no-build-tree
	docker build final-with-build-tree --tag="nobodyxu/llvm-toolchain:dev"

SHELL: /bin/bash
