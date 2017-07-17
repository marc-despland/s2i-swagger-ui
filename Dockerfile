FROM node

MAINTAINER Marc Despland <marc.despland@orange.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Create a swagger-ui image from a yaml documentation and a proxy to an example server" \
      io.k8s.display-name="builder swagger-ui" \
      io.openshift.expose-services="8080:http" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.openshift.tags="builder,swagger-ui"

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ /usr/libexec/s2i

WORKDIR /opt/app-root
RUN mkdir /opt/app-root/swagger

# Copy the lighttpd configuration file
COPY ./swagger-ui/ /opt/app-root/
RUN npm install

RUN groupadd --gid 1001 s2i && useradd --gid 1001 --uid 1001 -m s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["usage"]
