# API Proxy

A docker image with handebars / yq / yq and envsubst which is utilized for
generating nginx configuration based on env vars and a mounted `services.yaml.tmpl` File.

## Build docker image

```bash
docker build -t api-proxy:latest .
```

## How it works

For each version of your services, environment variables which provide
space-separated lists of upstreams are consumed when executing the entrypoint:

```bash
V1_UPSTREAMS="example.com:7701 example.com:7702"
```

Those are inserted in [services.yaml.tmpl](examples/with_sunsets/services.yaml.tmpl) utilizing [envtpl](https://github.com/subfuzion/envtpl).

After validation of the config, [nginx](nginx) conf files are generated with [handlebars](https://handlebarsjs.com/) templating.

Take a look at the examples to learn more about configuration.

For further insights, check [schema.json](hbs/schema.json) used for validation of the services config.

## Try it out

For a quick and easy example, copy and adjust the .env.example to .env
and change it as needed.

```bash
cp .env.example .env
```

```bash
docker run \
  --env-file=./.env \
  -v `pwd`/examples/with_sunsets/services.yaml.tmpl:/services.yaml.tmpl \
  -p 7755:80 \
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




