# Fedora Docker: systemd

This docker container provides a systemd enabled Fedora container usable as base container for when systemd is services are required.

This container is based on the work documented [here](https://vpavlin.eu/2015/02/fedora-docker-and-systemd/).

### Build & Run

```sh
docker build -t fedora:systemd .
docker run \
  --detach=true \
  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --name systemd \
  fedora:systemd
```

### Pull & Run

```sh
docker pull alectolytic/systemd
docker run \
  --detach=true \
  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --name systemd \
  alectolytic/systemd
```

The above `run` commands will start a detached instance of the container with the name `systemd`.

### Stop

```sh
docker stop systemd
```
