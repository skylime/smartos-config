#!/usr/bin/bash

## Load configuration information from USBKey
. /lib/svc/share/smf_include.sh
. /lib/sdc/config.sh

load_sdc_sysinfo
load_sdc_config

## Set the PATH environment because of other commands in /usr
PATH=/usr/bin:/usr/sbin:${PATH}

## Symlink some config files to the root user
for fullpath in /opt/custom/profile/*; do
	filename=${fullpath##*/}
	ln -nsf "${fullpath}" "/root/.${filename}"
done

## Setup crontabs only for root user
cat /opt/custom/crontab/* | crontab

## Special configuration by hostname
if [[ -d "/opt/custom/script/${hostname}" ]]; then
	for script in "/opt/custom/script/${hostname}/"*.sh; do
		./${script} ${hostname}
	done
fi

exit $SMF_EXIT_OK
