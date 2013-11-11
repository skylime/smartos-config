#!/usr/bin/bash

## Load configuration information from USBKey
. /lib/svc/share/smf_include.sh
. /lib/sdc/config.sh

load_sdc_sysinfo
load_sdc_config

## Set the PATH environment because of other commands in /usr
PATH=/usr/bin:/usr/sbin:${PATH}

## Setup fully qualified domain name
hostname=${CONFIG_admin_nic//:/-}
if [[ ${CONFIG_dns_domain} ]]; then
	cp /etc/inet/hosts /tmp
	sed "s_${hostname}\$_${hostname} ${hostname}.${CONFIG_dns_domain}_g" /tmp/hosts \
		> /etc/inet/hosts
fi

exit $SMF_EXIT_OK
