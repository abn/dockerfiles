# Dockerfile: Apache ActiveMQ on Fedora

A fedora based Apache ActiveMQ container.

```
docker pull alectolytic/activemq
```

## Build and Run
### Build
```
docker build --tag fedora/activemq .
```

### Run
```
HOST_DATA_DIR=/path/to/data
HOST_CONFIGS=/path/to/config/overlay

# note that the default credentials on jetty are disabled by default
# this file re-enables them
cat > ${HOST_CONFIGS}/jetty-realm.properties << EOF
admin: admin, admin
user: user, user
EOF

docker run \
    -p 8161:8161 \
    -v ${HOST_DATA_DIR}:/opt/apache-activemq/data \
    -v ${HOST_CONFIGS}:/var/run/activemq/conf \
    fedora/activemq
```

## Hooks and Configuration overlay
By default, no user configuration is loaded and no hooks are executed before starting ActiveMQ.

#### Hooks
The hooks are run every-time the server starts and they are available. These can be added at run time by using `-v ${HOOKS_DIR}:/var/run/activemq/hooks` option. This makes the hooks available to the instance. Only executable files whose name matches `*.sh` is executed.

#### Configuration
This container providers for specific configuration files to be replaced before the ActiveMQ server starts. Any configuration file that is intended to be replaced can be added to a local directory on the host and injected by passing `-v ${CONF_DIR}:/var/run/activemq/conf` to the run command. See the [Run section](#Run) for an example use case.

**Note:** This will supersedes any configurations mounted via the ${ACTIVEMQ_HOME}/conf.

## Environment Variables
For a full list refer to the dockerfile.

```
ENV ACTIVEMQ_VERSION=5.11.1
ENV ACTIVEMQ_SOURCE=${ACTIVEMQ_MIRROR}/${ACTIVEMQ_URL_PATH}
ENV ACTIVEMQ_HOME=/opt/apache-activemq/
ENV ACTIVEMQ_CONF=${ACTIVEMQ_HOME}/conf
ENV ACTIVEMQ_DATA=${ACTIVEMQ_HOME}/data
ENV ACTIVEMQ_USER=activemq
ENV ACTIVEMQ_RUN=/var/run/activemq
ENV ACTIVEMQ_OPTS=""
```

## Volumes
The following volumes can be mounted from the host.

| Volume  | Description |
| :------------ | :------------ |
| /opt/apache-activemq/conf | ActiveMQ configuration files. |
| /opt/apache-activemq/data | ActiveMQ data directory. |
| /var/run/activemq/conf | Runtime configuration overlay. See [configuration section](#configuration). |
| /var/run/activemq/hooks |Runtime hooks. See [hooks section](#hooks). |

## Ports
| Port  | Description |
| :------------ | :------------ |
| **8161** | AMQ HTTP port |
| **8162** | AMQ HTTPS port |
| **61616** | AMQ Openwire port |
| **1883** | AMQ MQTT port |
| **5672** | AMQ AMQP port |
| **61613** | AMQ STOMP port |
| **61617** | AMQ Openwire over SSL port |
| **8883** | AMQ MQTT over SSL port |
| **5671** | AMQ AMQP over SSL port |
| **61614** | AMQ STOMP over SSL port|
