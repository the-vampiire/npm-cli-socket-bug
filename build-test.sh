#!/usr/bin/env bash

set -e

base_tag='npm-cli-socket-bug'

attempt_builds() {
  dockerfile="$1"
  tag="$2"

  echo "running 20 build attempts of Dockerfile [$dockerfile] tag [$tag]"
  for build_attempt in {0..20}; do
    echo "build attempt: [${build_attempt}]"
    docker build --no-cache -t "$tag" -f "$dockerfile" .
  done
  echo "completed 20 build attempts without failure"
}

run() {
  host="$1"
  echo "running build tests on host [$host]"

  attempt_builds Dockerfile "$base_tag:no-8.3"
  attempt_builds Dockerfile.downgrade "$base_tag:downgrade-8.3"
}

run "$(uname -a)"
