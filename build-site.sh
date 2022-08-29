#!/bin/bash
SITE_SRC="$HOME/site"
SITE_DST="/srv/site"

docker create --cidfile "/tmp/jekyllcid" --volume="$SITE_DST:/dst" jekyll/jekyll bash -c 'chown 1000:1000 -R /src && jekyll build --source /src --destination /dst'
docker cp "$SITE_SRC" "$(cat /tmp/jekyllcid):/src/"
docker start -i -a "$(cat /tmp/jekyllcid)"
rm /tmp/jekyllcid
