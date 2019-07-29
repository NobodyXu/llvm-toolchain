.PHONY: build run
build:
	docker build . --tag="nobodyxu/llvm-toolchain" \
	               $(${NO_APT_PROXY} && echo "--build-arg APT_PROXY_PORT=''") \
		       $(${NO_GIT_PROXY} && echo "--build-arg GIT_PROXY_PORT=''")

SHELL: /bin/bash
