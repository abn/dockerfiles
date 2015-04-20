# Fedora Docker: libvirtd

This docker container provides a running libvirt daemon that can be linked to from clients that require libvirtd.

This container has been derrived from the great work done by the [Project Atomic crew](http://www.projectatomic.io/blog/2014/10/libvirtd_in_containers/). I highly recommend reading the linked post.

### Build

```sh
docker build -t libvirtd
```

### Run

```sh
# use alectolytic/libvirtd if pulling from dockerhub
# use '--net host --expose 16509' if client is not linked
docker run \
  --privileged \
  --detach=true \
  --name libvirtd \
  libvirtd
```

This command will start a detached instance of the container with the name `libvirtd`.

### Stop

```sh
docker stop libvirtd
```

## Volumes
The following volumes can be mounted from the host.

| Volume  | Description |
| :------------ | :------------ |
| /sys/fs/cgroup | [Control Group Resource Management](https://libvirt.org/cgroups.html) |
| /var/lib/libvirt | Host libvirt directory. |
| /var/lib/libvirt/images | Default storage pool. |

## Ports
| Port  | Description |
| :------------ | :------------ |
| **16509** | TCP port for client connections if not linked. |
