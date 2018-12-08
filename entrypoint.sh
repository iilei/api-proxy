#!/usr/bin/env sh

export NODE_PATH=/usr/lib/node_modules

# parse services.yaml.tmpl by envsubst and write to services.json
envtpl < services.yaml.tmpl | yq -M  -r '.' > services.json


hbs -H '/helpers/**.js' \
    -P '/partials/**.hbs' \
    --data '/services.json' \
    -e conf \
    --output dist/ \
    'templates/**/*.hbs'

nginxbeautifier -s 4 -r /dist/
