FROM fedora:21
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>

RUN yum -y install \
    deltarpm supervisor
RUN yum -y update
RUN yum -y install \
    quagga
RUN yum -y clean all

ADD assets/supervisord.conf /etc/supervisord.conf
ADD assets/bgpexpert-configure /usr/bin/bgpexpert-configure

VOLUME ["/etc/quagga/"]
EXPOSE 179 2605

CMD ["/usr/bin/supervisord", "-n"]

ONBUILD RUN yum -y update
