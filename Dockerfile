# spring-boot-runtime-image
FROM registry.redhat.io/rhel7/rhel-atomic

USER root

# TODO: Set labels used in OpenShift to describe the builder image
LABEL maintainer="Miguel Cuartin <macuartin@gmail.com>" \
      io.k8s.description="Platform for building spring boot applications" \
      io.k8s.display-name="spring boot builder" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

# Install Java and other tools
COPY ./jre /usr/local/java/jre

ENV PATH=$PATH:/usr/local/java/jre/bin

# Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
COPY --chown=root:root ./s2i/bin/ /usr/libexec/s2i
RUN chmod +x /usr/libexec/s2i/*

# TODO: Set the default port for applications built using this image
# EXPOSE 8080

WORKDIR /usr/local/app
