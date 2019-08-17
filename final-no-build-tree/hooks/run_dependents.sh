#!/bin/bash -x

git clone https://github.com/NobodyXu/llvm-toolchain.git
git checkout ${1}
git merge --ff-only master

# Set up user, email and passwd
git config --local user.name "$GITHUB_ROBOT_USER"
git config --local user.email "$GITHUB_ROBOT_EMAIL"

git config --local credential.helper store
echo "https://${GITHUB_ROBOT_USER}:${GITHUB_ROBOT_ACCESS_TOKEN}@github.com" > ~/.git-credentials

exec git push
