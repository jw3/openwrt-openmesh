#!/usr/bin/env bash

readonly ref="${1?usage: build.sh <git-ref> [image-name]}"
readonly img="${2:-latest}"

SOURCE_BRANCH="$ref" IMAGE_NAME="$img" ./hooks/build
