# Strict


If the requested version has no corresponding upstream, you will receive a message like the following via the response headers:

```
> curl -X GET http://localhost:1731/ -H 'Accept: application/vnd.my-app.acme.inc.v3+txt' -I

# equivalent to
> curl -X GET http://localhost:1731/ -H 'Accept: application/vnd.my-app.acme.inc.txt version=3' -I

# Response Headers:
HTTP/1.1 200 OK
...
```

If you dont't provide the accept header as desired, the request will fail.

```
> curl -X GET http://localhost:1731/ -H 'Accept: application/vnd.my-app-acme.inc.v3+txt' -I

# Response Headers:
HTTP/1.1 410 Gone
Warning: 410 - Bad Accept-Header; Requested version must be v2 or v3;
...
```

*Note the difference in the `Accept` Header*
