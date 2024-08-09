#!/usr/bin/env bash
set -e

case "$1" in
proxy)
    exec java \
        -Dpretixscan.database="${PRETIXSCAN_PROXY_DATABASE}" \
        -Dpretixscan.baseurl="${PRETIXSCAN_PROXY_BASEURL}" \
        -Dpretixscan.adminauth="${PRETIXSCAN_PROXY_ADMINAUTH}" \
        -Dpretixscan.autoOfflineMode="${PRETIXSCAN_PROXY_AUTO_OFFLINE_MODE}" \
        -Djava.util.prefs.userRoot=/data/config \
        -jar /pretix/pretixscan-proxy.jar
    ;;
**)
    exec bash -ec "$@"
esac

