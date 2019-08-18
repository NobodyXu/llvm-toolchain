#!/bin/bash -ex
# see:
# https://github.com/sameersbn/docker-apt-cacher-ng
# https://gist.github.com/dergachev/8441335

HOST_IP=$(awk '/^[a-z]+[0-9]+\t00000000/ { printf("%d.%d.%d.%d\n", "0x" substr($3, 7, 2), "0x" substr($3, 5, 2), "0x" substr($3, 3, 2), "0x" substr($3, 1, 2)) }' < /proc/net/route)

# The following code add git proxy
# It is writen by nobodyxu
GIT_PROXY_HOST="$3"
GIT_PROXY_PORT="$4"

[ -z "$GIT_PROXY_HOST" ] && GIT_PROXY_HOST="$HOST_IP"
[ -z "$GIT_PROXY_PORT" ] && GIT_PROXY_PORT="8080"

if [[ ! -z "$GIT_PROXY_PORT" ]] && [[ ! -z "$GIT_PROXY_HOST" ]] && (echo >"/dev/tcp/${GIT_PROXY_HOST}/${GIT_PROXY_PORT}") &>/dev/null; then
    git config --global url."http://$GIT_PROXY_HOST:$GIT_PROXY_PORT/".insteadOf https://
    # Since my git cache use core.compression 9, I using the same level here.
    git config --global core.compression 9
fi
