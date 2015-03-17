# Dockerfile: Apache Zookeeper on Fedora

A fedora based Apache Zookeeper container.

```
docker pull alectolytic/zookeeper
```

## Build and Run
### Build
```
docker build --tag fedora/zookeeper .
```

### Run
```
HOST_DATA_DIR=/path/to/data
HOST_CONF_DIR=/path/to/conf
HOST_LOG_DIR=/path/to/log

docker run \
    -p 2181:2181 \
    -v ${HOST_DATA_DIR}:/var/lib/zookeeper/data \
    -v ${HOST_CONF_DIR}:/var/lib/zookeeper/conf \
    -v ${HOST_LOG_DIR}:/var/lib/zookeeper/log \
    fedora/zookeeper
```

## Configuration
As any zookeeper instance, the configuration directory can contain `zoo.cfg`, `log4j.properties` etc.

These files are linked at `/etc/zookeeper` for use by the start script.

## Environment Variables
For a full list refer to the dockerfile.

```
ENV ZOO_ETC=/etc/zookeeper
ENV ZOO_HOME=/var/lib/zookeeper
ENV ZOO_CONF=${ZOO_HOME}/conf
ENV ZOO_DATA=${ZOO_HOME}/data
ENV ZOO_LOG=${ZOO_LOG}/log
ENV ZOO_USER=zookeeper
```

## Volumes
The following volumes can be mounted from the host.

| Volume  | Description |
| :------------ | :------------ |
| /var/lib/zookeeper/conf | Zookeeper [configuration](#Configuration) |
| /var/lib/zookeeper/data | Zookeeper data |
| /var/lib/zookeeper/log | Zookeeper logs |

## Ports
| Port  | Description |
| :------------ | :------------ |
| **2181** | Client port |
| **2888** | Follower connection port (if leader) |
| **3888** | Server connection port (during leader election) |
