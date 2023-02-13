# Docker in Google Cloud Shell

It's very easy to pull and run a container in Cloud Shell. e.g.

```sh
mike_saunby@cloudshell:~ (docker-demo-2023)$ docker pull tiangolo/uwsgi-nginx-flask
mike_saunby@cloudshell:~ (docker-demo-2023)$ docker run  -p 8080:80 docker.io/tiangolo/uwsgi-nginx-flask:latest
```

The web preview feature enables forwarding of port 8080 to you web browser.

## Docker command line

The first commands you'll use will be ```pull``` and ```run``` but fairly soon you'll be wanting to know if a container is running in the background, clean up stopped containers, remove unused images....etc.

https://docs.docker.com/engine/reference/commandline/cli/

```sh
docker container prune
WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N] y
Deleted Containers:
4a7f7eebae0f63178aff7eb0aa39cd3f0627a203ab2df258c1a00b456cf20063
f98f9c2aa1eaf727e4ec9c0283bc7d4aa4762fbdba7f26191f26c97f64090360

Total reclaimed space: 212 B
```

There's nothing to stop you building and pushing images from Cloud Shell.

Typically containers build on base images that provide a complete run time environment for the programming language used by the application. Where something more bespoke is needed then we can build on base images such as **ubuntu:22.04** and use a package manager to install libraries and tools. e.g.
```yaml
FROM ubuntu:22.04
RUN apt update && apt install -y --no-install-recommends r-base
```