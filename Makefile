.PHONY: build no-build-tree with-build-tree stage1 base run
build: with-build-tree

base:
	./build_base.sh

stage1: base
	docker build stage1 --tag="nobodyxu/llvm-toolchain:stage1"

no-build-tree: stage1
	docker build final-no-build-tree --tag="nobodyxu/llvm-toolchain:latest"

with-build-tree: no-build-tree
	docker build final-with-build-tree --tag="nobodyxu/llvm-toolchain:dev"

SHELL: /bin/bash
