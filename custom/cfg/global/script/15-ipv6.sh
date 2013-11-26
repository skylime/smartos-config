#!/usr/bin/bash

. /lib/svc/share/smf_include.sh
. /lib/sdc/config.sh

load_sdc_sysinfo
load_sdc_config

# Run through every NIC tag
for tag in ${SYSINFO_Nic_Tags//,/ }; do
	iface=SYSINFO_NIC_${tag}

	# Run through existing tag instance ids
	sdc_config_keys | sed -n "s:${tag}\([0-9]\{1,\}\)_v6_ip:\1:p" | while read instance; do
		v6_ip=CONFIG_${tag}${instance}_v6_ip
		v6_gw=CONFIG_${tag}${instance}_v6_gateway

		# Be sure ip address and gateway exists
		if [[ -n "${!v6_ip}" ]]; then
			v6_iponly=$(echo ${!v6_ip} | sed 's:/.*::')
			ifconfig ${!iface} inet6 plumb up
			ifconfig ${!iface} inet6 addif ${!v6_ip} up

			if [[ -n "${!v6_gw}" ]]; then
				route add -inet6 ${!v6_gw} ${v6_iponly} -interface
				route add -inet6 default ${!v6_gw}
			fi
		fi
	done
done

exit $SMF_EXIT_OK
