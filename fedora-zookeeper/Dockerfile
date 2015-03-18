FROM fedora:latest
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>

RUN yum -y install deltarpm \
    && yum -y update
RUN yum -y install \
    supervisor \
    java jline slf4j-log4j12 \
    zookeeper
RUN yum -y clean all

ENV ZOO_ETC=/etc/zookeeper
ENV ZOO_HOME=/var/lib/zookeeper
ENV ZOO_CONF=${ZOO_HOME}/conf
ENV ZOO_DATA=${ZOO_HOME}/data
ENV ZOO_LOG=${ZOO_HOME}/log
ENV ZOO_USER=zookeeper

ADD assets/supervisord.conf /etc/supervisord.conf
ADD assets/zookeeper-start /bin/zookeeper-start
ADD assets/conf/java.env ${ZOO_ETC}/java.env

# ensure configuration files can be modified by ZOO_USER
RUN chown -R ${ZOO_USER}:${ZOO_USER} ${ZOO_HOME} ${ZOO_ETC}

# fix class path issue
# https://bugzilla.redhat.com/show_bug.cgi?id=1181487 
RUN ENVFILE=/usr/libexec/zkEnv.sh \
    && sed -i /'^CLASSPATH='/d ${ENVFILE} \
    && LOG4J_JAR=$(find /usr/share/java -name 'log4j12-1*.jar' | head -n 1 | xargs -I {} basename {}) \
    && echo "CLASSPATH=\$(/usr/bin/build-classpath ${LOG4J_JAR} zookeeper/zookeeper slf4j/slf4j-log4j12 slf4j/slf4j-api jline):${ZOO_ETC}/" >> ${ENVFILE}

USER ${ZOO_USER}
WORKDIR ${ZOO_HOME}

# add default config
RUN mkdir -p ${ZOO_CONF}
RUN cp ${ZOO_ETC}/* ${ZOO_CONF}
RUN mv ${ZOO_CONF}/zoo_sample.cfg ${ZOO_CONF}/zoo.cfg

EXPOSE 2181 2888 3888

VOLUME ["${ZOO_CONF}", "${ZOO_DATA}", "${ZOO_LOG}"]

CMD ["/usr/bin/supervisord", "-n"]
