#!/bin/bash
SITE_SRC="$PWD"

docker run -it --volume="$SITE_SRC:/src" -p 4000:4000 jekyll/jekyll bash -c 'cd /src && bundler install && jekyll serve'
