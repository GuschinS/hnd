#!/bin/sh
# Builds index.html (a full HTML document for GitHub Pages)
# from have-a-nice-day.html (the page body used for the Claude artifact).
# Run after every edit of have-a-nice-day.html:  sh build.sh
set -e
cd "$(dirname "$0")"
SRC=have-a-nice-day.html
OUT=index.html

# Everything up to and including the first </style> goes into <head>.
HEAD_END=$(grep -n '</style>' "$SRC" | head -1 | cut -d: -f1)

{
  printf '%s\n' '<!doctype html>' '<html lang="en">' '<head>'
  printf '%s\n' '<meta charset="utf-8">'
  printf '%s\n' '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">'
  printf '%s\n' '<meta name="description" content="Hanse 575 HAVE A NICE DAY, built 2014, lying in Gdańsk. Sailing yacht for sale.">'
  printf '%s\n' '<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0;font:14px system-ui,sans-serif}img{max-width:100%}[hidden]{display:none!important}</style>'
  head -n "$HEAD_END" "$SRC"
  printf '%s\n' '</head>' '<body>'
  tail -n +"$((HEAD_END + 1))" "$SRC"
  printf '%s\n' '</body>' '</html>'
} > "$OUT"

echo "Built $OUT"
