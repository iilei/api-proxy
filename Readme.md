# API Proxy

A docker image with handebars / yq / yq and envsubst which is utilized for
generating nginx configuration based on env vars and a mounted `services.yaml.tmpl` File.

Get it [on dockerhub](https://cloud.docker.com/repository/docker/iil3i/api-proxy)

## Motivation: Versioning for public APIs

In the context of Lean Development it is often discussed where to draw the *yagni*-Line: you want to ship early, and for the first version,
why worry about how you are going to deal with breaking changes that *might* occur at some point in time in the future? It is consuming and
it might lead to a less forgiving API concept than needed at the time of the first roll-out.

On the other hand, setting clear boundaries for communication between clients and your public api from the beginning comes with the benefit
it prevents confusion on the API-consumers side when a breaking API change is about to happen. In that case you'll want to know how to run
multiple versions in parallel for the transition time and how clients are going to request the exact versions they are known to play well with.

More important, you want to ensure your API-consumers are aware they need to define a version when communicating with your API.
In the case of all examples provided here, that is via `Accept` Header based content negotiation.

See [interagent/http-api-design](https://github.com/interagent/http-api-design/blob/master/en/foundations/require-versioning-in-the-accepts-header.md#require-versioning-in-the-accepts-header)
guide for more context on the reasoning.

So I wanted to come up with a quick-and-easy way to incorporate a reverse proxy that serves as a baby-steps-API gateway for the early life time of public APIS.
The days when it seems too much effort to go for a more sophisticated API-Gateway like
[krakend](https://www.krakend.io/),
[Kong](https://github.com/Mashape/kong),
[Traefik](https://github.com/containous/traefik),
[Caddy](https://github.com/mholt/caddy),
[Linkerd](https://github.com/linkerd/linkerd),
[Fabio](https://github.com/fabiolb/fabio),
[Vulcand](https://github.com/vulcand/vulcand),
[Netflix Zuul](https://github.com/Netflix/zuul) or
[similar](https://gist.github.com/StevenACoffman/acf1133da6c5ff5226c0f6eb8fbd8132)


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
* [strict](examples/strict) `docker-compose --file examples/strict/docker-compose.yml up`
* [sunsets](examples/sunsets) `docker-compose --file examples/sunsets/docker-compose.yml up`

**Please note:** The end-of-life date is solely exposed but will not be used to disable the respective upstream.
Hence, to actually turn off old versions they must be taken off from the services.yaml.tpl and a rebuild is needed.

If you use this container just for building the nginx config itself and sync it with another container that runs `nginx:1.15.7-alpine`,
you just need to sync the newly created config and do a `nginx -s reload`.

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

