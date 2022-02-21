#!/usr/bin/env bash

set -e

base_tag='npm-cli-socket-bug'

attempt_builds() {
  build_count="$1"
  dockerfile="$2"
  tag="$3"

  echo "running [$build_count] build attempts of Dockerfile [$dockerfile] [$tag] on host [$(uname)]"

  for build_attempt in {0..$build_count}; do
    echo "build attempt: [${build_attempt}]"
    docker build --no-cache -t "$tag" -f "$dockerfile" . 1> /dev/null
    echo "build attempt: [${build_attempt}] completed without failure"
  done

  echo "completed [$build_count] build attempts without failure"
}

run() {
  build_count="${1:-20}"
  attempt_builds $build_count Dockerfile.upgrade "$base_tag:upgrade-8.5.1"
  # attempt_builds $build_count Dockerfile.downgrade "$base_tag:downgrade-8.3"
  # attempt_builds $build_count Dockerfile "$base_tag:no-8.3"
}

run "$@"
