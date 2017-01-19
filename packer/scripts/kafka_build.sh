#!/bin/bash

set -eux

DIST_URL="http://www-us.apache.org/dist/"
DOWNLOAD_URL="${DIST_URL}/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
KAFKA_FOLDER="kafka_${SCALA_VERSION}-${KAFKA_VERSION}"

cd /tmp
curl -O ${DOWNLOAD_URL} -O ${DOWNLOAD_URL}.asc

tar xzvf "${KAFKA_FOLDER}.tgz"

mv ${KAFKA_FOLDER} /opt
ln -s /opt/${KAFKA_FOLDER} /opt/kafka

useradd --home-dir /opt/kafka-data --no-create-home --shell /usr/sbin/nologin --no-log-init kafka

#log4j automatically rotates, so we need to cleanup old logs with a cron or via log4j
#cp /tmp/init-files/logrotate.d/* /etc/logrotate.d/

cp /tmp/init-files/default/kafka.env /etc/default/kafka
cp /tmp/init-files/default/zookeeper.env /etc/default/kafka-zookeeper

cp /tmp/init-files/systemd/kafka.service /etc/systemd/system
cp /tmp/init-files/systemd/kafka-zookeeper.service /etc/systemd/system
