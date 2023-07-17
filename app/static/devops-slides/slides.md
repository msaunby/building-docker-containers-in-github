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

* GitHub Actions

* Pre-requisites for CI

* Example projects

* The Dockerfile

* DNS


## What is DevOps?

Devops is a contraction of Development and Operations.  Traditionally folks involved in either of these would have very little involvement with the other.  This might seem strange, but consider that software development typically includes design, testing, tuning, debugging, code management, etc. and operations can include performance, support, maintenance, porting, security, cost management, etc. There needed to be some separation.  

DevOps is made possible not just by technology, code management systems have been around a very long time, but by software becoming so big that it needs to be broken down into smaller parts.  Some businesses chose to break their software down into services, each of which can be enabled and supported by a small team.


## CI/CD

* Continuous Integration

* Continuous Delivery

* Continuous Deployment


## GitHub Actions

Actions are workflows that are triggered by events.  For example when changes are commited to a code repository the test suites are run and any errors reported.

As well as running tests, automated workflows are often used to build software packages, create distributable releases and deploy websites and services. 

See <https://docs.github.com/en/actions/using-workflows/about-workflows>


## Pre-requisites for CI

To integrate the system all the component parts need to be built and any other resources, e.g. configuration files and databases, must be available.

We also need to know how to integrate the system, e.g. where files are placed the directory structure.

Finally there should be some tests to ensure the integration is correct.


## Example projects

If you are designing building something entirely new then you hopefully plan to automate testing and deployment.  If, more likely, you are starting with an existing project, perhaps with no build scripts or tests, then the first thing to do is try to build and run the system.

**<https://github.com/UniExeterRSE/team-day-jul-2023-s3-website>**

(S3 + Cloudflare) https://demo1.wetoffice.com/ 

**<https://github.com/UniExeterRSE/team-day-jul-2023-lightsail-docker>**

(Google) https://dash-example-4zmip6wjzq-od.a.run.app/ 

(Lightsail) https://container-service-1.hp100t40rijde.eu-west-2.cs.amazonlightsail.com/ 

 


## The Dockerfile

The Dockerfile describes how to build the container and, optionally, the command to run. 

Here's an example for a Python Flask application.

```yaml
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

If you would rather use pipenv there are useful tips here
<https://til.simonwillison.net/docker/pipenv-and-docker>


## DNS

DNS records 

The following domain names were configured in Cloudflare in advance of the workshop. 

```txt
demo1.wetoffice.com demo2.wetoffice.com 
a1.wetoffice.com	a2.wetoffice.com	a3.wetoffice.com 
b1.wetoffice.com	b2.wetoffice.com	b3.wetoffice.com 
c1.wetoffice.com	c2.wetoffice.com	c3.wetoffice.com 
d1.wetoffice.com	d2.wetoffice.com	d3.wetoffice.com 
e1.wetoffice.com	e2.wetoffice.com	e3.wetoffice.com 
```

Each of these should point to an S3 bucket with the same name.  Once you create a bucket with static website content, you should have a working website. 

```txt
The DNS records look like this
TYPE		NAME	TARGET 
CNAME		a1	a1.wetoffice.com.s3-website.eu-west-2.amazonaws.com	 
```


## [The End](/)