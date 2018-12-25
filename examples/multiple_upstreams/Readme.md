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

Or simply check the output in your terminal
