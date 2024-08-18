#!/bin/bash
SITE_SRC="$PWD"
SITE_DST="$PWD/build"


docker create --cidfile "/tmp/hugocid" --volume="$SITE_DST:/dst" ghcr.io/hugomods/hugo:latest sh -c "chown $UID:$GID -Rv /src && cd /src/site && hugo --destination /dst"
docker cp "$SITE_SRC" "$(cat /tmp/hugocid):/src"
docker start -i -a "$(cat /tmp/hugocid)"
docker container rm "$(cat /tmp/hugocid)"
rm /tmp/hugocid
