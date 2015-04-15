#!/usr/bin/env bash

# Derrived from http://www.projectatomic.io/blog/2014/10/libvirtd_in_containers/

TLS_LISTEN=${TLS_LISTEN-0}
TLS_PORT=${TLS_PORT-16514}

TCP_LISTEN=${TCP_LISTEN-1}
TCP_PORT=${TCP_PORT-16509}
AUTH_TCP=${AUTH_TCP-none}

yum -y install \
    libvirt-daemon-driver-* \
    libvirt-daemon \
    libvirt-daemon-kvm \
    qemu-kvm

systemctl enable libvirtd
systemctl enable virtlockd 

# Enable TCP only if not embedded
if [ -z ${EMBEDDED} ]; then
    cat >> /etc/libvirt/libvirtd.conf << DELIM
listen_tls = 0
listen_tcp = 1
tls_port = "${TLS_PORT}"
tcp_port = "${TCP_PORT}"
auth_tcp = "${AUTH_TCP}"
DELIM

    echo 'LIBVIRTD_ARGS="--listen"' >> /etc/sysconfig/libvirtd
else
    # if embeded install client stuff
    yum -y install virt-viewer virt-install libvirt-client
fi

# Edit the service file which includes ExecStartPost to chmod /dev/kvm
sed -i "/Service/a ExecStartPost=\/bin\/chmod 666 /dev/kvm" /usr/lib/systemd/system/libvirtd.service

# make images directory for volume mount
mkdir -p /var/lib/libvirt/images/
