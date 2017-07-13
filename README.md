# S2I-Swagger-UI

This is an [S2I](https://github.com/openshift/source-to-image) image use to build Swagger-UI server to expose your api documentation with a proxy to access to your API server.

You can remove the tag **host** then the internal proxy will be use to access your server

Define the environment variable **TARGET_URL** to access your server API


## Requirements

* [S2I](https://github.com/openshift/source-to-image)
* [Docker](https://www.docker.com/products/docker)


## To build the S2I image

	1. Clone this repository
	2. Execute 
```docker build -t s2i-swagger-ui .```

## To build an image with your application code
With GIT url and --context-dir you have to provide the folder that contain the file swagger.yaml

```s2i build git://<source code> --context-dir /swagger s2i-swagger-ui <application image>```

For example :
```s2i build https://github.com/marc-despland/fiware.git --context-dir /Orion/swagger s2i-swagger-ui fiware/orion-apidocs```

## To run your image with Docker

```docker run -it --rm <application image>```

The server will listen on port 8080

The swagger docs is accessible here http://<containerip>:8080/api/docs 
