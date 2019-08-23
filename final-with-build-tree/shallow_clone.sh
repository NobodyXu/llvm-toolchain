#!/bin/bash -x

src=/opt/llvm/src/llvm
dst=/root/llvm/src/llvm

mkdir -p $dst

local_clone() {
    git clone --progress -s --depth 1 --single-branch  file://${src}/${1} ${dst}/${1}
}

local_clone                          # Copy root project llvm
local_clone projects/libcxx
local_clone projects/compiler-rt
local_clone projects/libcxxabi
local_clone tools/clang
local_clone tools/clang/tools/extra
local_clone tools/lldb
local_clone tools/lld

mv ${src}/build-stage2 ${dst}/build-stage2
