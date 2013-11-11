#!/usr/bin/bash

## Load configuration information from USBKey
. /lib/svc/share/smf_include.sh
. /lib/sdc/config.sh

load_sdc_sysinfo
load_sdc_config

## Set the PATH environment because of other commands in /usr
PATH=/usr/bin:/usr/sbin:${PATH}

## Local variables
cfg='/opt/custom/cfg'

## Functions
function deploy() {
	folder="${cfg}/${1}"

	if [[ -d "${folder}" ]]; then
		# Copy all files from the root-folder
		[[ -d "${folder}/root" ]] && cp -a "${folder}/root/"* /

		# Run all scripts from the script-folder
		if [[ -d "${folder}/script" ]]; then
			for script in "${folder}/script/"*; do
				[[ -x "${script}" ]] && ./${script}
			done
		fi

		# Deploy cronjobs
		[[ -d "${folder}/cronjob" ]] && cat "${folder}/cronjob/"* | crontab
	fi
}

## Deploy global configuration
deploy "global"

## Deploy datacenter configuration
deploy "${SYSINFO_Datacenter_Name}"

## Deploy host configuration
deploy "${SYSINFO_Hostname}"

exit $SMF_EXIT_OK
