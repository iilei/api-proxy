#!/usr/bin/env bash
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
ajv validate -s /hbs/schema.json -d services.json

# copy
cp -rf /nginx/* /etc/nginx/
rm /etc/nginx/**/*.hbs

# as hbs flattens the target directory structure; walk through tree
dirs=$(find nginx/** -type d)
dirs[${#dirs[@]}]='nginx'

for dir in "${dirs[@]}"; do
hbs -H '/hbs/helpers/**.js' \
    -P '/hbs/partials/**.hbs' \
    --data /services.json \
    --extension conf \
    --output /etc/$dir/ \
    /$dir/*.hbs
done

nginxbeautifier -s 4 -r /etc/nginx/

nginx -t

nginx -g 'daemon off;'
