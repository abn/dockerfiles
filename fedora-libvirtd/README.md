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
docker run --privileged --detach=true --env='container=docker' \
    --volume /proc/modules:/proc/modules \
    --volume /var/lib/libvirt/:/var/lib/libvirt/ \
    --volume /sys/fs/cgroup:/sys/fs/cgroup:rw \
    --name libvirtd libvirtd
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
| /sys/fs/cgroup | [Contron Group Resource Management](https://libvirt.org/cgroups.html) |

## Ports
| Port  | Description |
| :------------ | :------------ |
| **16509** | TCP port for client connections if not linked. |
