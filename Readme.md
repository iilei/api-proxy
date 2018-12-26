# API Proxy

A docker image with handebars / yq / yq and envsubst which is utilized for
generating nginx configuration based on env vars and a mounted `services.yaml.tmpl` File.

Get it [on dockerhub](https://cloud.docker.com/repository/docker/iil3i/api-proxy)

## How it works

For each version of your services, environment variables which provide
space-separated lists of upstreams are consumed when executing the entrypoint:

```bash
export V1_UPSTREAMS="example.com:7701 example.com:7702"
```

Those are inserted in [services.yaml.tmpl](examples/basic/services.yaml.tmpl) utilizing [envtpl](https://github.com/subfuzion/envtpl).

After validation of the config, [nginx](nginx) conf files are generated with [handlebars](https://handlebarsjs.com/) templating.

## Try it out

Check the examples:

* [basic](examples/basic) `docker-compose --file examples/basic/docker-compose.yml up`
* [multiple upstreams](examples/multiple_upstreams) `docker-compose --file examples/multiple_upstreams/docker-compose.yml up`
* [rewrite](examples/rewrite) `docker-compose --file examples/rewrite/docker-compose.yml up`
* [sunsets](examples/sunsets) `docker-compose --file examples/sunsets/docker-compose.yml up`

**Please note:** The end-of-life date is solely exposed but will not be used to disable the respective upstream.
Hence, to actually turn off old versions they must be taken off from the services.yaml.tpl and a restart is needed.

Check [sunsetHeader.hbs](hbs/partials/sunsetHeader.hbs) and [unsatisfiableVersion.hbs](hbs/partials/unsatisfiableVersion.hbs)
to learn how these messages are composed.

## Advanced config

Take a look at the [examples](examples) to learn more about configuration.

For further insights, check [schema.json](hbs/schema.json) used for validation of the services config.

## Customize

Create your own services.yaml and .env file, Adjust to your liking:

```bash
cp examples/basic/services.yaml.tmpl ./
cp .env.example .env
```

Once you have adjusted both files to your needs, run

```bash
docker run \
  --env-file=./.env \
  -v `pwd`/services.yaml.tmpl:/services.yaml.tmpl \
  -p 1731:80 \
  api-proxy
```

## Further customization

If you want custom templates, simply mount your own `hbs` and  `nginx` volumes

