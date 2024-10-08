#!/bin/bash
SITE_SRC="$PWD"

docker run --user $UID:$GID -it --rm --mount type=bind,src=/etc/localtime,target=/etc/localtime,readonly --mount type=bind,src="$SITE_SRC",target=/src -p 1313:1313 ghcr.io/hugomods/hugo:latest sh -c 'cd /src && hugo server --bind 0.0.0.0 --disableFastRender'
