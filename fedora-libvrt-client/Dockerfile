FROM fedora:latest
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>

# Derrived from http://www.projectatomic.io/blog/2014/10/libvirtd_in_containers/

RUN yum -y update

# install libvirt client tools
RUN yum -y install \
    virt-viewer virt-install libvirt-client

# clean up
RUN yum -y clean all

# configure libvirt tcp connection
# the hostname libvirtd is injected when we link the libvirt host container
RUN echo 'uri_default = "qemu+tcp://libvirtd/system"' >> /etc/libvirt/libvirt.conf

VOLUME [ "/var/lib/libvirt/" ]

CMD ["/usr/bin/virsh"]

ONBUILD RUN yum -y update && yum -y clean all
