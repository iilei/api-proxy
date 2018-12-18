# API Proxy

A docker image with handebars / yq / yq and envsubst which is utilized for
generating nginx configuration based on env vars and a mounted `services.yaml.tmpl` File.

## Build docker image

```bash
docker build -t api-proxy:latest .
```

## Try it out

For a quick and easy example, run the following:

```bash
docker run \
  --env-file=./.env \
  -v `pwd`/examples/with_sunsets/services.yaml.tmpl:/services.yaml.tmpl \
  -v `pwd`/hbs:/hbs \
  -v `pwd`/nginx:/nginx \
  -p 8099:80 \
  api-proxy
```

## Customize

Create your own services.yaml and .env file, Adjust to your liking:

```bash
cp examples/with_sunsets/services.yaml.tmpl ./
cp .env.example .env
```

Once you have adjusted both files to your needs, run

```bash

docker run \
  --env-file=./.env \
  -v `pwd`/services.yaml.tmpl:/services.yaml.tmpl \
  -p 8099:80 \
  api-proxy
```




