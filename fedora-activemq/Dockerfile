FROM fedora:latest
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>

RUN yum -y install \
    deltarpm wget tar supervisor \
    java
RUN yum -y update && yum -y clean all

ENV ACTIVEMQ_VERSION=5.11.1
ENV ACTIVEMQ_MIRROR=http://apache.mirror.uber.com.au
ENV ACTIVEMQ_URL_PATH=activemq/${ACTIVEMQ_VERSION}/apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz
ENV ACTIVEMQ_SOURCE=${ACTIVEMQ_MIRROR}/${ACTIVEMQ_URL_PATH}
ENV ACTIVEMQ_HOME=/opt/apache-activemq/
ENV ACTIVEMQ_CONF=${ACTIVEMQ_HOME}/conf
ENV ACTIVEMQ_DATA=${ACTIVEMQ_HOME}/data
ENV ACTIVEMQ_USER=activemq
ENV ACTIVEMQ_RUN=/var/run/activemq

ENV HTTP_PORT=8161
ENV HTTPS_PORT=8162
ENV OPENWIRE_PORT=61616
ENV MQTT_PORT=1883
ENV AMQP_PORT=5672
ENV STOMP_PORT=61613
ENV OPENWIRE_SSL_PORT=61617
ENV MQTT_SSL_PORT=8883
ENV AMQP_SSL_PORT=5671
ENV STOMP_SSL_PORT=61614

# prepare activemq system user
RUN useradd \
    --home-dir ${ACTIVEMQ_HOME} --no-create-home \
    --system \
    --comment "ActiveMQ User" \
    ${ACTIVEMQ_USER}

# create home directory with amq release
RUN cd /tmp \
    && TARBALL=$(basename ${ACTIVEMQ_SOURCE}) \
    && wget --output-document=${TARBALL} ${ACTIVEMQ_SOURCE} \
    && tar xvf ${TARBALL} \
    && mv apache-activemq-${ACTIVEMQ_VERSION} ${ACTIVEMQ_HOME} \
    && chown -R ${ACTIVEMQ_USER}:${ACTIVEMQ_USER} ${ACTIVEMQ_HOME} \
    && rm ${TARBALL}

# prepare run directory to provide runtime changes
RUN mkdir -p ${ACTIVEMQ_RUN}

# add assets
ADD assets/supervisord.conf /etc/supervisord.conf
ADD assets/activemq-start /bin/activemq-start
ADD assets/conf ${ACTIVEMQ_RUN}/conf
ADD assets/hooks ${ACTIVEMQ_RUN}/hooks

USER ${ACTIVEMQ_USER}
WORKDIR ${ACTIVEMQ_HOME}

# disable default users
RUN echo "" > ${ACTIVEMQ_CONF}/jetty-realm.properties

VOLUME ["${ACTIVEMQ_RUN}/conf", "${ACTIVEMQ_RUN}/hooks", \
        "${ACTIVEMQ_CONF}", "${ACTIVEMQ_DATA}"]

EXPOSE ${HTTP_PORT} ${HTTPS_PORT} ${OPENWIRE_PORT} ${MQTT_PORT} ${AMQP_PORT} \
    ${STOMP_PORT} ${OPENWIRE_SSL_PORT} ${MQTT_SSL_PORT} ${AMQP_SSL_PORT} \
    ${STOMP_SSL_PORT}

CMD ["/usr/bin/supervisord", "-n"]
