FROM alectolytic/systemd
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>

# Derrived from http://www.projectatomic.io/blog/2014/10/libvirtd_in_containers/
RUN yum -y update

# configure libvirtd
ENV TCP_PORT=16509
ENV SCRIPT_SRC=https://raw.githubusercontent.com/abn/dockerfiles/master/scripts/
RUN curl --silent ${SCRIPT_SRC}/docker-install-libvirtd.sh \
    | bash

EXPOSE ${TCP_PORT}

RUN yum -y clean all

VOLUME ["/var/lib/libvirt"]
