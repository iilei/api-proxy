# API Proxy

A docker image with handebars / yq / yq and envsubst which is utilized for
generating nginx configuration based on env vars and a mounted `services.yaml.tmpl` File.

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

# Build docker image

```bash
docker build -t iil3i/api-proxy:latest .
```

For a quick and easy example, copy and adjust the .env.example to .env
and change it as needed.


```bash
docker-compose --file examples/with_sunsets/docker-compose.yml --project-directory . up
```

Try accessing your proxied upstreams a few times:

```
> curl -X GET http://localhost:1731/ -H 'Accept: application/vnd.my-app.v3+txt'

# Response Body:
Server address: 172.21.0.4:80
Server name: 427f04d1fa9e
Date: 25/Dec/2018:13:28:29 +0000
URI: /
Request ID: 6de14ef3e2c93bd259786e9de3f050c1
```

To verify the `Server name` is one of the upstreams that are set for v3, check the container IDs:

```bash
docker container ls --filter "name=service_v3" --format "{{.ID}}"
``` 

If the requested version has no corresponding upstream, you will receive a message like the following via the response headers:

```
> curl -X GET http://localhost:1731/ -H 'Accept: application/vnd.my-app.v23+txt' -I

# Response Headers:
HTTP/1.1 410 Gone
Server: nginx
Date: Tue, 25 Dec 2018 13:35:52 GMT
Content-Type: text/html
Content-Length: 136
Connection: keep-alive
Warning: 410 - Requested version must be v1, v2 or v3; Recommended: v3
```

If it is merely a deprecated version which has not yet reached its sunset:

```
> curl -X GET http://localhost:1731/ -H 'Accept: application/vnd.my-app.v2+txt' -I

# Response Headers:
HTTP/1.1 200 OK
Server: nginx
Date: Tue, 25 Dec 2018 13:38:07 GMT
Content-Type: text/plain
Content-Length: 141
Connection: keep-alive
Expires: Tue, 25 Dec 2018 13:38:06 GMT
Cache-Control: no-cache
Warning: 299 - Deprecated: v2; Sunset: Tue, 23 Nov 2021 22:59:00 GMT; Recommended: v3

```

**Please note:** The end-of-life date is solely exposed but will not be used to disable the respective upstream.
Hence, to actually turn off old versions they must be taken off from the services.yaml.tpl and a restart is needed.

Check [sunsetHeader.hbs](hbs/partials/sunsetHeader.hbs) and [unsatisfiableVersion.hbs](hbs/unsatisfiableVersion.hbs)
to learn how these messages are composed.

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
  -p 1731:80 \
  api-proxy
```

## Further customization

If you want custom templates, simply mount your own `hbs` and  `nginx` volumes


