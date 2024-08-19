#!/bin/bash
SITE_SRC="$PWD"
FILENAME="$1"

docker run --user $UID:$GID -it --rm --mount type=bind,src="$SITE_SRC",target=/src ghcr.io/hugomods/hugo:latest sh -c "cd /src && hugo new content blog/posts/$FILENAME/index.md"
