FROM fedora:latest
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>

RUN yum -y install deltarpm \
    && yum -y update
RUN yum -y install \
    wget tar supervisor \
    scala
RUN yum -y clean all

ENV SCALA_VERSION=2.10
ENV KAFKA_VERSION=0.8.2.1
ENV APACHE_MIRROR=http://mirror.ventraip.net.au/apache
ENV KAFKA_URLPATH=kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
ENV KAFKA_SOURCE=${APACHE_MIRROR}/${KAFKA_URLPATH}
ENV KAFKA_HOME=/opt/apache-kafka/
ENV KAFKA_COF=${KAFKA_HOME}/conf
ENV KAFKA_LOG=${KAFKA_HOME}/logs
ENV KAFKA_USER=kafka
ENV KAFKA_RUN=/var/run/kafka
ENV KAFKA_OPTS=""

ENV BROKER_PORT=9092

# prepare activemq system user
RUN useradd \
    --home-dir ${KAFKA_HOME} --no-create-home \
    --system \
    --comment "KAFKA User" \
    ${KAFKA_USER}

# create home directory with amq release
RUN cd /tmp \
    && TARBALL=$(basename ${KAFKA_SOURCE}) \
    && wget --output-document=${TARBALL} ${KAFKA_SOURCE} \
    && tar xvf ${TARBALL} \
    && mv ${TARBALL/.tgz/} ${KAFKA_HOME} \
    && chown -R ${KAFKA_USER}:${KAFKA_USER} ${KAFKA_HOME} \
    && rm ${TARBALL}

# prepare run directory to provide runtime changes
RUN mkdir -p ${KAFKA_RUN} \
    && chown -R ${KAFKA_USER}:${KAFKA_USER} ${KAFKA_RUN}

# prepare log directory
RUN mkdir -p ${KAFKA_LOG} \
    && chown -R ${KAFKA_USER}:${KAFKA_USER} ${KAFKA_LOG}

# add assets
ADD assets/supervisord.conf /etc/supervisord.conf
ADD assets/kafka-start /bin/kafka-start
ADD assets/conf ${KAFKA_RUN}/conf
ADD assets/hooks ${KAFKA_RUN}/hooks

USER ${KAFKA_USER}
WORKDIR ${KAFKA_HOME}

VOLUME ["${KAFKA_RUN}/conf", "${KAFKA_RUN}/hooks", "${KAFKA_CONF}", \
    "${KAFKA_DATA}", "${KAFKA_LOG}"]

EXPOSE ${BROKER_PORT}

CMD ["/usr/bin/supervisord", "-n"]
