#!/bin/bash -x

git clone https://github.com/NobodyXu/llvm-toolchain.git
cd llvm-toolchain

# Test whether master is ahead of the branch ${1}
if [ "$(git rev-list --left-right --count origin/master...origin/${1} | cut -f 1)" != 0 ]; then
    
    git checkout ${1}
    git merge --ff-only master
    
    # Set push.default for push
    git config --local push.default simple
    
    # Set up username and passwd
    git config --local credential.helper store
    echo "https://${GITHUB_ROBOT_USER}:${GITHUB_ROBOT_ACCESS_TOKEN}@github.com" > ~/.git-credentials
    
    exec git push origin HEAD
fi
