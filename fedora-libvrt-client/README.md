# Fedora Docker: libvirtd

This docker container provides a libvirt client connecting to a linked libvirtd container.

This container has been derrived from the great work done by the [Project Atomic crew](http://www.projectatomic.io/blog/2014/10/libvirtd_in_containers/). I highly recommend reading the linked post.

### Build

```sh
docker build -t libvirt-client
```

### Run

Note that this expects a [libvirtd container](https://github.com/abn/dockerfiles/tree/master/fedora-libvirtd) running with the name _libvirtd_.

```sh
# use alectolytic/libvirt-client if pulling from docker hub
docker run -it \
    --link libvirtd:libvirtd \
    libvirt-client
```

This client expects the libvirtd hostname to injected as libvirtd (via `--link`). By default this drops to an interactive `virsh` shell.


## Volumes
The following volumes can be mounted from the host.

| Volume  | Description |
| :------------ | :------------ |
| /var/lib/libvirt/ | libvirt storage. |

## Ports

No ports are exposed.
