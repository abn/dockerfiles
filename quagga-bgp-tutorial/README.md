# Dockerfile: Quagga BGP Tutorial

A fedora based container for [Iljitsch van Beijnum](Iljitsch van Beijnum)'s [quagga BGP tutorial](http://www.bgpexpert.com/course.php).

### Pull pre-built image
```
docker pull alectolytic/quagga-bgp-tutorial
```

### Build from source
```
docker build --tag alectolytic/quagga-bgp-tutorial .
```

### Run

#### Create configuration directory on host
```
export QUAGGA_CONFIG=$(pwd)/quagga-config
mkdir -p ${QUAGGA_CONFIG}
```

#### Configure your router instance
This uses the configuration generated from the [course website](http://www.bgpexpert.com/course.php). The argument given is your router name for the tutorial. In the example `F` is used.

```
docker run \
  --volume ${QUAGGA_CONFIG}:/etc/quagga \
  alectolytic/quagga-bgp-tutorial bgpexpert-configure F
```
#### Run `bgpd` and `zebra`
```
docker run \
  --detach \
  --volume ${QUAGGA_CONFIG}:/etc/quagga \
  --publish 179:179 \
  --publish 2605:2605 \
  alectolytic/quagga-bgp-tutorial
```

#### Connect to the container
```
telnet localhost 2605
```

#### Stopping the container
To stop, identify the container id, then stop it.

```
$ docker ps
CONTAINER ID        IMAGE                COMMAND                CREATED             STATUS              PORTS                                          NAMES
a0c599f711e0        ralectolytic/quagga-bgp-tutorial:latest   "/usr/bin/supervisor   8 seconds ago       Up 7 seconds        0.0.0.0:179->179/tcp, 0.0.0.0:2605->2605/tcp   backstabbing_tesla
$ docker stop a0c599f711e0
```

## Launching multiple instances
To do this we create three configuration directories, and configure routers with different ids then start them. Note that we do not map the ports explicitly here.

```sh
export QUAGGA_CONFIG=$(pwd)/quagga

for NAME in A B C; do
    mkdir -p ${QUAGGA_CONFIG}.${NAME}
    docker run \
        --volume ${QUAGGA_CONFIG}.${NAME}:/etc/quagga \
        alectolytic/quagga-bgp-tutorial bgpexpert-configure ${NAME}
    docker run \
        --detach \
        --volume ${QUAGGA_CONFIG}:/etc/quagga \
        --publish 179 \
        --publish 2605 \
        alectolytic/quagga-bgp-tutorial
done
```

#### Identifying host ports
```
$ docker ps
CONTAINER ID        IMAGE                                    COMMAND                CREATED             STATUS              PORTS                                             NAMES
0a772ec6314d        alectolytic/quagga-bgp-tutorial:latest   "/usr/bin/supervisor   3 seconds ago       Up 2 seconds        0.0.0.0:32772->179/tcp, 0.0.0.0:32773->2605/tcp   prickly_lalande
8c021cb657de        alectolytic/quagga-bgp-tutorial:latest   "/usr/bin/supervisor   5 seconds ago       Up 4 seconds        0.0.0.0:32771->179/tcp, 0.0.0.0:32770->2605/tcp   boring_leakey
a0eed04d992a        alectolytic/quagga-bgp-tutorial:latest   "/usr/bin/supervisor   8 seconds ago       Up 6 seconds        0.0.0.0:32768->179/tcp, 0.0.0.0:32769->2605/tcp   naughty_davinci
```

## Volumes
The following volumes can be mounted from the host.

| Volume  | Description |
| :------------ | :------------ |
| /etc/quagga | Quagga configuration files. |

## Ports
| Port  | Description |
| :------------ | :------------ |
| **179** | BGP/tcp port |
| **2605** | Telnet port |
