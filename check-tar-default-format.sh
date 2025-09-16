#!/bin/sh

set -ux
set -o pipefail

IMAGE=$1
TAG=${2:-latest}
PRERUN=${3:-}

echo "## $IMAGE"
if [ ! -z "$PRERUN" ]; then
    docker run --rm ${IMAGE}:${TAG} sh -c "$PRERUN && tar --help" | grep -F -e '*This* tar defaults to:' -A 1 | sed -ne '1d;s/\s.*$//;p';
else
    docker run --rm ${IMAGE}:${TAG} sh -c "tar --help" | grep  -F -e '*This* tar defaults to:' -A 1 | sed -ne '1d;s/\s.*$//;p'
fi

if [ $? -ne 0 ]; then
    echo 'N/A'
fi
