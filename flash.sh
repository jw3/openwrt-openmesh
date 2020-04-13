#!/usr/bin/env bash

readonly dev="${1?usage:flash.sh <eth-device> [tag]}"
readonly tag="${2:-latest}"

docker run --rm -it --privileged --network=host openwrt-openmesh ap51-flash "$dev" lede-ar71xx-generic-om2p-squashfs-factory.bin
