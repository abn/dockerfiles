# Dockerfile: Apache Kafka on Fedora

A fedora based Apache Kafka container.

```
docker pull alectolytic/kafka
```

## Build and Run
### Build
```
docker build --tag fedora/kafka .
```

### Run
Before you can run kafka; you need a named [Zookeeper container](https://github.com/abn/dockerfiles/tree/master/fedora-zookeeper#dockerfile-apache-zookeeper-on-fedora) up and running. You can name the container using `--name zoo` when running it.

```
HOST_LOG_DIR=/path/to/log
HOST_CONF_DIR=/path/to/config/overlay

# example zookeeper run
docker run -d \
    --name zoo \
    fedora/zookeeper

# note the '--link zoo:localhost' option
# zoo refers to the name you've given to the zookeeper instance
# localhost refers to the host alias, this is used in
# server.properties (change default from localhost if required)
docker run \
    -p 9092:9092 \
    -v ${HOST_LOG_DIR}:/opt/apache-kafka/logs \
    -v ${HOST_CONF_DIR}:/var/run/kafka/conf \
    --link zoo:localhost
    fedora/kafka
```

## Hooks and Configuration overlay
By default, no user configuration is loaded and no hooks are executed before starting Kafka.

#### Hooks
The hooks are run every-time the server starts and they are available. These can be added at run time by using `-v ${HOOKS_DIR}:/var/run/kafka/hooks` option. This makes the hooks available to the instance. Only executable files whose name matches `*.sh` is executed.

#### Configuration
This container providers for specific configuration files to be replaced before the Kafka server starts. Any configuration file that is intended to be replaced can be added to a local directory on the host and injected by passing `-v ${CONF_DIR}:/var/run/kafka/conf` to the run command. See the [Run section](#Run) for an example use case.

**Note:** This will supersedes any configurations mounted via the ${KAFKA_HOME}/conf.

## Environment Variables
For a full list refer to the dockerfile.

```
ENV SCALA_VERSION=2.10
ENV KAFKA_VERSION=0.8.2.1
ENV KAFKA_HOME=/opt/apache-kafka/
ENV KAFKA_COF=${KAFKA_HOME}/conf
ENV KAFLA_LOG=${KAFKA_HOME}/log
ENV KAFKA_USER=kafka
ENV KAFKA_RUN=/var/run/kafka
ENV KAFKA_OPTS=""
ENV BROKER_PORT=9092
```

## Volumes
The following volumes can be mounted from the host.

| Volume  | Description |
| :------------ | :------------ |
| /opt/apache-kafka/conf | Kafka configuration files. |
| /opt/apache-kafka/data | Kafka data directory. |
| /var/run/kafka/conf | Runtime configuration overlay. See [configuration section](#configuration). |
| /var/run/kafka/hooks |Runtime hooks. See [hooks section](#hooks). |

## Ports
| Port  | Description |
| :------------ | :------------ |
| **9092** | Broker port |
