# Basic with default set

*Note:* You should consider favoring strict over permissive if possible.
See [interagent/http-api-design](https://github.com/interagent/http-api-design/blob/master/en/foundations/require-versioning-in-the-accepts-header.md#require-versioning-in-the-accepts-header) guide

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
Warning: 410 - Requested version must be v2 or v3
```

If you omit the versioion the default will be served (v3)

```
> curl -X GET http://localhost:1731/
```
