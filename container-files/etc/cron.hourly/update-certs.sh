#!/bin/sh
exec /usr/bin/timeout --kill-after 35m  30m  yum update -y --disablerepo=* --enablerepo=osg osg-ca-certs
