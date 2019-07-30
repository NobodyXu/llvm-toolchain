#!/usr/bin/env bash

# A simple git wrapper to prevent git from failing in low-speed area
# due to timeout or whatever.
git() {
    while true; do
        /usr/bin/env GIT_HTTP_LOW_SPEED_LIMIT=-0.1 GIT_HTTP_LOW_SPEED_TIME=999999 git "$@"
        [ $? -ne 0 ] && [ -n "$1" ] && ([ "$1" = "clone" ] || [ "$1" = "fetch" ] || [ "$1" = "pull" ]) || break
	sleep 10s
    done
}

source /tmp/install-clang/install-clang -D /opt/llvm
