When a Flask app is run you'll see
```
 WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 ```

 These notes explain why, and how, to use a production server.

## Why not use the built-in Flask web server?

The build in, development, server is single threaded, and quite likely has other performance and security issues.

It's very easy to create a suitable production server in a Docker container.

## Other considerations

### Cloud hosting

### HTTP/2

By default, Google Cloud Run downgrades HTTP/2 requests to HTTP/1 when those requests are sent to the container. There is a deployment setting, under Networking, that will override this.

The size of requests (uploads) can be unlimited if HTTP/2 is used.
Websockets can be used.

<https://cloud.google.com/run/quotas>

### HTTPS

Probably required for HTTP/2


## Tests

<https://cloud.google.com/run/docs/configuring/http2>

``curl -i --http2-prior-knowledge http://localhost:PORT
```


## Examples

<https://blog.miguelgrinberg.com/post/running-your-flask-application-over-https>

<https://medium.com/python-pandemonium/how-to-serve-http-2-using-python-5e5bbd1e7ff1>

## Docker test

```
% docker build -t building-docker-containers .
% docker run -p 8080:80 building-docker-containers:latest
```


When running Docker locally it's likely you will create a lot of test containers.  To remove all stopped containers.
```
% docker container prune
WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N]
```
