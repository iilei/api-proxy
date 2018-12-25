# Rewrite route params

In the services.yaml a rewrite pattern is defined for `/geo/` 

```yaml
proxies:
  /geo/:
    default: v2
    rewrite: "/geocoding-service/$1"
```

Hence the generated `/etc/nginx/conf.d/locations.conf` looks like follows:

```txt
# cat /etc/nginx/conf.d/locations.conf

location ~ ^/geo/ {
    if ($geo_version = "unsatisfiable_version") {
        add_header Warning '410 - Requested version must be v2; Service: geo'
        always;
        return 410;
    }

    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    # see https://tenzer.dk/nginx-with-dynamic-upstreams/
    # or https://distinctplace.com/2017/04/19/nginx-resolver-explained/
    # for why a trailing slash at the end of proxy_pass does not work when a
    # variable as the parameter for proxy_pass is used.
    rewrite ^/geo/(.*) /geocoding-service/$1 break;

    proxy_pass $scheme://$geo_version;

}
location ~ ^/tax/ {
    if ($tax_version = "unsatisfiable_version") {
        add_header Warning '410 - Requested version must be v2 or v3; Service: tax'
        always;
        return 410;
    }

    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    # see https://tenzer.dk/nginx-with-dynamic-upstreams/
    # or https://distinctplace.com/2017/04/19/nginx-resolver-explained/
    # for why a trailing slash at the end of proxy_pass does not work when a
    # variable as the parameter for proxy_pass is used.
    rewrite ^/tax/(.*) /$1 break;

    proxy_pass $scheme://$tax_version;

}

```

Note the default is `/$1` which is applied to the `/tax/` endpoint in this example.
