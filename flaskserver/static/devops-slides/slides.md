<!-- The reveal.js default style is good for small screens, but I like to get a bit more content in each slide
so I've made the fonts smaller, and when I want titles in capitals I'll write them in CAPITALS. -->
<style>
			.reveal p {
      	font-size: 0.65em;
				text-transform: None;
				text-align: left;
    		}
			.reveal h2 {
				font-size: 1.2em;
				text-transform: None;
				text-align: center;
			}
			.reveal h3 {
				font-size: 1.0em;
				text-transform: None;
				text-align: left;
			}
			.reveal code {
				font-size: 0.65em;
			}
</style>	
## Introduction to DevOps and GitHub Actions

* What is DevOps?

* CI/CD

* GitHub Actions (and limitations)

* An example Python project

* The Dockerfile

* What next?  (building big systems.  See https://yonatankra.com/2-ways-to-use-your-docker-image-in-github-actions/)



## What is DevOps?

Devops...



## CI/CD

Continuous Integration

Continuous Delivery

Continuous Deployment


## GitHub Actions

Actions...

## An example Python project

### Project overview

### Pre-requisites for CI

To integrate the system all the component parts need to be built and any other resources, e.g. configuration files and databases, must be available.

We also need to know how to integrate the system, e.g. where files are placed the directory structure.

Finally there should be some tests to ensure the integration is correct.

### A real project

If you are designing building something entirely new then you will plan all the above.  If, more likely, you are starting with an existing project, perhaps with no build scripts or tests, then the first thing to do is try to build and run the system.

This project is a Dash web application written in Python.  No requirements.txt file or and details on what Python version was used for development, but as this is a new project, still under development I'm going to assume Python 3.11 (the latest release as I write).  

*In the past I would have used virtualenv by running ```python3.11 -m venv .venv```  
Note that VSCode will generally detect such an envirnoment automatically, and ask if you wish to use it for the current workspace.*

```sh
$ /usr/local/bin/python3.11 -m pip install pipenv
```

Now this is done all that is needed to prepare a virtual environment is -
```sh
$ cd <PROJECT_DIR>
$ pipenv shell
% pipenv install dash
```
This project depends on several other Python packages.  In most cases you can just try and run the program and resolve any missing packages like this -

```sh
ModuleNotFoundError: No module named 'pandas'
% pipenv install pandas    
```

If this doesn't work, you'll need to either know, or do some Googling.  e.g.

```sh
ModuleNotFoundError: No module named 'sklearn'
% pipenv install scikit-learn
```


## The Dockerfile

<https://til.simonwillison.net/docker/pipenv-and-docker>

The Dockerfile describes how to build the container and, optionally, the command to run. 

```yaml [1-14|1-9|11-14]
FROM python:3.11-slim-bullseye
ARG VERSION
WORKDIR /app
# Install packages from requirements.txt
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip &&\
    pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt
# Copy source code to working directory
COPY flaskserver ./flaskserver

# Default env vars and command.
ENV PORT=5000
ENV VERSION=$VERSION
CMD ["python", "flaskserver"]
```


## Docker build

The Dockerfile is a configuration file for the **docker build** tool. Each instruction in the Dockerfile adds additional layers to the base image. Docker build produces a lot of output, like this -

```sh
Run docker build . --file Dockerfile --tag my-image-name:$(date +%s)
Sending build context to Docker daemon  7.893MB

Step 1/7 : FROM python:3.11-slim-bullseye
3.11-slim-bullseye: Pulling from library/python
bb263680fed1: Pulling fs layer
43900b2bbd7f: Pulling fs layer
...
---> 79e97cd43c08
Step 3/7 : COPY requirements.txt .
 ---> 7c1c862a25e9
Step 4/7 : RUN pip install --no-cache-dir --upgrade pip &&    pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt
 ---> Running in e4113ad35f0f
Requirement already satisfied: pip in /usr/local/lib/python3.11/site-packages (22.3.1)
Collecting pip
  Downloading pip-23.0-py3-none-any.whl (2.1 MB)
...
```




## GitHub Actions

The output in the last slide was copied from a report generated automatically by GitHub. These are produced when a GitHub Action runs.

GitHub Actions are automated workflows that use containers to build, test and deploy software. Here's an action to build a Docker container.

```yaml
name: Docker Image CI
on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Build the Docker image
      run: docker build . --file Dockerfile --tag my-image-name:$(date +%s)
```



## Container registry

A registry provides secure storage of container images with version control based on the tags given to images when pushed. The default container registry is Docker Hub. As we are building our container on GitHub a free Docker Hub account is sufficient. 

![](screenshot-dockerhub.png)




## Deploy

Deploying a container is very simple, we just tell the hosting service the URL of the image to deploy.

![](screenshot-cloudrun1.png)


## Deploy (Google Cloud)

<https://building-docker-containers-in-github-2w4u2b57sa-od.a.run.app>

![](screenshot-cloudrun2.png)



## Live demo

* GitHub pull-request already submitted

* Approve the pull-request

* Create a new release

* GitHub action builds and pushes the new image

* Manually update the deployed version in Google Cloud

Typically the last step is also automated, and there would be automated tests of the code before building the container.




## Deployment

### Build on GitHub

![](deployment.svg)


### Build on Google, AWS, Docker, etc.

![](deployment2.svg)




## What next?

### Google Cloud Shell

Click on ```[>_]``` for command line tools including git and docker.

```sh
$ git clone <your repo>
$ cd <repo dir>
$ docker build -t testimg .
....
$ docker run -p 8080:5000 testimg
```

### Containers as development environments

"The Visual Studio Code Dev Containers extension lets you use a container as a full-featured development environment."

<https://code.visualstudio.com/docs/devcontainers/containers>

### Docker Compose and Kubernetes

<https://docs.docker.com/compose/>

<https://microk8s.io/>


## [The End](/)