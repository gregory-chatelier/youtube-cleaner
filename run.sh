#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: ./run.sh <YouTube_URL>"
  exit 1
fi

URL="$1"

docker run --rm --memory="8g" -v "$(pwd)/out:/out" youtube-cleaner "$URL"
