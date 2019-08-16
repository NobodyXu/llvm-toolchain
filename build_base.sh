#!/usr/bin/env bash

exec docker build base --tag="nobodyxu/llvm-toolchain:base" \
	               $(${NO_APT_PROXY} && echo "--build-arg APT_PROXY_PORT=''") \
	               $([ -n "${APT_PROXY_HOST}" ] && echo "--build-arg=APT_PROXY_HOST=${APT_PROXY_HOST}") \
	               $([ -n "${APT_PROXY_PORT}" ] && echo "--build-arg=APT_PROXY_PORT=${APT_PROXY_PORT}") \
	               $([ -n "${GIT_PROXY_PORT}" ] && echo "--build-arg=GIT_PROXY_PORT=${GIT_PROXY_PORT}") \
	               $([ -n "${GIT_PROXY_HOST}" ] && echo "--build-arg=GIT_PROXY_HOST=${GIT_PROXY_HOST}") \
		       $(${NO_GIT_PROXY} && echo "--build-arg GIT_PROXY_PORT=''")
