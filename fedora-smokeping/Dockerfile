FROM fedora:latest
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>

RUN yum -y install \
    deltarpm supervisor
RUN yum -y update
RUN yum -y install \
    httpd \
    echoping fping sendmail \
    smokeping
RUN yum -y clean all

# prepare runtime config directory
RUN mkdir -p /var/run/smokeping/config

ADD assets/supervisord.conf /etc/supervisord.conf

VOLUME ["/var/run/smokeping/config"]
EXPOSE 80

CMD ["/usr/bin/supervisord", "-n"]
