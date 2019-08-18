#!/usr/bin/env bash

[ -z "${need_userns_workaround}" ] && need_userns_workaround=false

exec docker build "$1" --tag="nobodyxu/llvm-toolchain:${2}" \
		       --build-arg need_userns_workaround=${need_userns_workaround}
