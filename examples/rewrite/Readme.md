# Rewrite route params

In the services.yaml a rewrite pattern is defined for `/geo/` 

```yaml
proxies:
  /geo/:
    rewrite: "/geocoding-service/$1"
```

Hence the generated `/etc/nginx/conf.d/locations.conf` looks like follows:

```txt
# cat /etc/nginx/conf.d/locations.conf

location ~ ^/geo/ {
    ...
    rewrite ^/geo/(.*) /geocoding-service/$1 break;
    ...
}

```
