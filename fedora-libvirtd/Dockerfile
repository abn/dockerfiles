FROM fedora:latest
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>

# Derrived from http://www.projectatomic.io/blog/2014/10/libvirtd_in_containers/

RUN yum -y update

# configure systemd and libvirtd
ENV SCRIPT_SRC=https://raw.githubusercontent.com/abn/dockerfiles/master/scripts/

RUN curl --silent ${SCRIPT_SRC}/docker-install-systemd.sh \
    | bash
RUN TCP_PORT=16509; \
    curl --silent ${SCRIPT_SRC}/docker-install-libvirtd.sh \
    | bash

EXPOSE 16509

RUN yum -y clean all

VOLUME ["/sys/fs/cgroup"]

CMD ["/usr/sbin/init"]
