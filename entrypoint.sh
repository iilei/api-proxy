#!/usr/bin/env sh
set -e

export NODE_PATH=/usr/lib/node_modules

# parse services.yaml.tmpl by envsubst and write to services.json
echo "Utilizing 'envtpl' and 'yq' to generate services.json ..."
set -x
envtpl < services.yaml.tmpl | yq -M  -r '.' > services.json
set +x

echo "Result:"
jq '.' services.json

set -x
ajv validate -s schema.json -d services.json

hbs -H '/helpers/**.js' \
    -P '/partials/**.hbs' \
    --data '/services.json' \
    -e conf \
    --output dist/ \
    'templates/**/*.hbs'

nginxbeautifier -s 4 -r /dist/

cp /dist/* /etc/nginx/

nginx -t
