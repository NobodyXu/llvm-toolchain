.PHONY: build dev latest stage1 base run
build: dev

base:
	./build_base.sh

stage1: base
	docker build stage1 --tag="nobodyxu/llvm-toolchain:stage1"

latest: stage1
	./build-with-optional-workaround.sh final-no-build-tree latest

dev: no-build-tree
	./build-with-optional-workaround.sh final-with-build-tree dev

SHELL: /bin/bash
