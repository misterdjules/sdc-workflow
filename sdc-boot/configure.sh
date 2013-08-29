#!/usr/bin/bash
#
# Copyright (c) 2012 Joyent Inc., All rights reserved.
#

export PS4='[\D{%FT%TZ}] ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -o xtrace

role=workflow
PATH=/opt/smartdc/$role/build/node/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin

$(/opt/local/bin/gsed -i"" -e "s/@@PREFIX@@/\/opt\/smartdc\/workflow/g" /opt/smartdc/$role/smf/manifests/wf-api.xml)
$(/opt/local/bin/gsed -i"" -e "s/@@PREFIX@@/\/opt\/smartdc\/workflow/g" /opt/smartdc/$role/smf/manifests/wf-runner.xml)

echo "Importing SMF Manifests"
$(/usr/sbin/svccfg import /opt/smartdc/$role/smf/manifests/wf-runner.xml)
$(/usr/sbin/svccfg import /opt/smartdc/$role/smf/manifests/wf-api.xml)

exit 0
