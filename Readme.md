
```
docker build --rm -t api-proxy-v2:latest .

docker run --env-file=./.env \
  -v `pwd`/services.yaml.tmpl:/services.yaml.tmpl \
  -v `pwd`/services.json:/services.json \
  -v `pwd`/schema.json:/schema.json \
  -v `pwd`/dist:/dist/ \
  -v `pwd`/helpers:/helpers/ \
  -v `pwd`/partials:/partials/ \
  -v `pwd`/templates:/templates/ \
  -i -t \
  -p 8099:80 api-proxy-v2
``` 
