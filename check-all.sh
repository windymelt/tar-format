#!/bin/sh

set -eux
set -o pipefail

LISTFILE=./images.txt
VERIFIER=./check-tar-default-format.sh

while read LINE; do
    IMAGE=$(echo "${LINE}" | awk -F ':' '{print $1}')
    TAG=$(echo "${LINE}" | awk -F ':' '{print $2}')
    PRERUN=$(echo "${LINE}" | awk -F ':' '{print $3}')
    $VERIFIER "${IMAGE}" "${TAG}" "${PRERUN}"
done < $LISTFILE
