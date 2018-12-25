## Deprecated but alive

A deprecated version which has not yet reached its sunset will be served with 200 OK but will also have a Warning added:

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

## Gone (probably)

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
