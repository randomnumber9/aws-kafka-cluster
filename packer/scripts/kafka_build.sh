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

mkdir -p /opt/kafka-data /opt/kafka/log/kafka /opt/kafka/log/zookeeper
chown kafka:kafka /opt/kafka-data /opt/kafka/log/kafka /opt/kafka/log/zookeeper

cp /tmp/init-files/kafka.env /etc/default/kafka
cp /tmp/init-files/zookeeper.env /etc/default/kafka-zookeeper

cp /tmp/init-files/kafka.service /etc/systemd/system
cp /tmp/init-files/kafka-zookeeper.service /etc/systemd/system
