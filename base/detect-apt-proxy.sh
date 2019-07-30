#!/bin/bash -ex
# see:
# https://github.com/sameersbn/docker-apt-cacher-ng
# https://gist.github.com/dergachev/8441335

APT_PROXY_PORT=$1
HOST_IP=$(awk '/^[a-z]+[0-9]+\t00000000/ { printf("%d.%d.%d.%d\n", "0x" substr($3, 7, 2), "0x" substr($3, 5, 2), "0x" substr($3, 3, 2), "0x" substr($3, 1, 2)) }' < /proc/net/route)

# The third condition testing command automatically test whether ${APT_PROXY_PORT} on ${HOST_IP} is open.
# It is adapted from:
#     https://www.google.com/amp/s/www.cyberciti.biz/faq/ping-test-a-specific-port-of-machine-ip-address-using-linux-unix/amp/
if [[ ! -z "$APT_PROXY_PORT" ]] && [[ ! -z "$HOST_IP" ]] && (echo >"/dev/tcp/${HOST_IP}/${APT_PROXY_PORT}") &>/dev/null; then
    echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy
    cat >> /etc/apt/apt.conf.d/01proxy <<EOL
    Acquire::HTTP::Proxy "http://${HOST_IP}:${APT_PROXY_PORT}";
EOL
    cat /etc/apt/apt.conf.d/01proxy
    echo "Using host's apt proxy"
else
    echo "No squid-deb-proxy detected on docker host"
fi

# The following code add git proxy
# It is writen by nobodyxu
GIT_PROXY_PORT="$2"
if [[ ! -z "$GIT_PROXY_PORT" ]] && [[ ! -z "$HOST_IP" ]] && (echo >"/dev/tcp/${HOST_IP}/${GIT_PROXY_PORT}") &>/dev/null; then
    git config --global url."http://$HOST_IP:$GIT_PROXY_PORT/".insteadOf https://
    # Since my git cache use core.compression 9, I using the same level here.
    git config --global core.compression 9
fi
