#!/bin/bash

apt install python

cd /tmp
curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
chmod +x awslogs-agent-setup.py
