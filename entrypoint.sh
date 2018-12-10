#!/usr/bin/env sh

export NODE_PATH=/usr/lib/node_modules

# parse services.yaml.tmpl by envsubst and write to services.json
envtpl < services.yaml.tmpl | yq -M  -r '.' > services.json

ajv validate -s schema.json -d services.json


hbs -H '/helpers/**.js' \
    -P '/partials/**.hbs' \
    --data '/services.json' \
    -e conf \
    --output dist/ \
    'templates/**/*.hbs'

nginxbeautifier -s 4 -r /dist/



# hbs --helper "/helpers/**/*.js" --partial "/partial/**/*.js" --data `pwd`/services.json templates/**/*.hbs -e conf --output dist/ && cat   /dist/location.conf

# select
# .proxy | values[] | .upstreams | values[] | values[] |  test("<no value>") | not

# .proxy | values[] | .upstreams | values[] | values[] | select( .| test("<no value>") | not  )
# replace "<no value>"
# yq '.proxy |  values[] | .upstreams | values[] | values[] '  services.yaml
# yq '.proxy | values |= map( .upstreams |= map(values |= map( del(select(.| test("<no value>"))))))'  services.yaml
# ( .proxy |  values[] | .upstreams | values[] | values[]  | select(test("<no value>")| not  ) )

#  yq '( .proxy |  values[] | .upstreams | values[] | values[] ) |= sub("<no value>"; null) '  services.yaml

# yq '. | map( .proxy | values | map( values | .upstreams | values[] | values |= map(if . == "<no value>" then (.|=null) else . end)   )  ) ' services.yaml
# yq '. |= map( .proxy | values | values | values | map( values[] |= "_")) ' services.yaml

# yq '. | map( .proxy | values | map( values | .upstreams | values[] | values[] | select(test("<no value>")|not) )  ) ' services.yaml

# yq '.' services.yaml
# interpolate ENV vars to services template

# yq -M -c . ./services.yaml
# yq -M -r -c '.proxy | values[]' services.yaml

# cp ./services.yaml.tmpl ./services.yaml.tmpl
# envtpl < services.yaml.tmpl > services.yaml
