#!/bin/bash -ex
# see:
# https://github.com/sameersbn/docker-apt-cacher-ng
# https://gist.github.com/dergachev/8441335

HOST_IP=$(awk '/^[a-z]+[0-9]+\t00000000/ { printf("%d.%d.%d.%d\n", "0x" substr($3, 7, 2), "0x" substr($3, 5, 2), "0x" substr($3, 3, 2), "0x" substr($3, 1, 2)) }' < /proc/net/route)

APT_PROXY_HOST=$1
APT_PROXY_PORT=$2

[ -z "$APT_PROXY_HOST" ] && APT_PROXY_HOST="$HOST_IP"
[ -z "$APT_PROXY_PORT" ] && APT_PROXY_PORT="8000"

# The third condition testing command automatically test whether ${APT_PROXY_PORT} on ${HOST_IP} is open.
# It is adapted from:
#     https://www.google.com/amp/s/www.cyberciti.biz/faq/ping-test-a-specific-port-of-machine-ip-address-using-linux-unix/amp/
if [[ ! -z "$APT_PROXY_PORT" ]] && [[ ! -z "$APT_PROXY_HOST" ]] && (echo >"/dev/tcp/${APT_PROXY_HOST}/${APT_PROXY_PORT}") &>/dev/null; then
    echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy
    cat >> /etc/apt/apt.conf.d/01proxy <<EOL
    Acquire::HTTP::Proxy "http://${APT_PROXY_HOST}:${APT_PROXY_PORT}";
EOL
    cat /etc/apt/apt.conf.d/01proxy
    echo "Using host's apt proxy"
else
    echo "No squid-deb-proxy detected on docker host"
fi

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
