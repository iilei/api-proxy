
```
docker build --rm  --no-cache -t api-proxy-v2:latest .

docker run \
  --name=api-proxy-v2 \
  --env-file=./.env \
  -v `pwd`/services.yaml.tmpl:/services.yaml.tmpl \
  -p 8099:80 \
  api-proxy-v2
``` 
