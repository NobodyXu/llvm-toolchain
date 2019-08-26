#!/bin/bash -x

git clone https://github.com/NobodyXu/llvm-toolchain.git
cd llvm-toolchain
git checkout ${1}

if ! git diff --quiet master ${1}; then
    git merge --ff-only master
    
    # Set push.default for push
    git config --local push.default simple
    
    # Set up username and passwd
    git config --local credential.helper store
    echo "https://${GITHUB_ROBOT_USER}:${GITHUB_ROBOT_ACCESS_TOKEN}@github.com" > ~/.git-credentials
    
    exec git push origin HEAD
fi
