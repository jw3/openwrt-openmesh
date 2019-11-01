#!/usr/bin/env bash

readonly ref="${1?usage: build.sh <git-ref> [image-name]}"
readonly tag="${2:-latest}"

SOURCE_BRANCH="$ref" IMAGE_NAME="openwrt-openmesh:$tag" ./hooks/build
