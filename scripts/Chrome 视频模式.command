#!/bin/zsh
exec "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --user-data-dir="$HOME/Library/Application Support/Chrome Video Mode" \
  --disable-accelerated-video-decode --no-first-run --no-default-browser-check \
  "https://www.youtube.com/"
