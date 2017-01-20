#!/bin/bash

set -eux

DOWNLOAD_FILE="jmx_prometheus_javaagent.jar"
DOWNLOAD_URL="https://s3.amazonaws.com/lifeway-binaries/public/${DOWNLOAD_FILE}"
JMXFOLDER = "jmx_exporter"
cd /tmp
mkdir ${JMXFOLDER}
curl -o ${JMXFOLDER}/${DOWNLOAD_FILE} ${DOWNLOAD_URL}

mv ${JMXFOLDER} /opt

cp /tmp/init-files/jmx_exporter/kafka.yml /opt/${JMXFOLDER}
