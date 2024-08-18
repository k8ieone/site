#!/bin/bash
SITE_SRC="$PWD"

docker run -it --rm --mount type=bind,src="$SITE_SRC",target=/src -p 1313:1313 ghcr.io/hugomods/hugo:latest sh -c 'cd /src && hugo server --bind 0.0.0.0 --disableFastRender'

