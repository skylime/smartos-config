#!/usr/bin/bash

. /lib/svc/share/smf_include.sh
. /lib/sdc/config.sh

load_sdc_sysinfo
load_sdc_config

ifconfig ${SYSINFO_NIC_admin} inet6 plumb up

if [[ -n "${CONFIG_admin_v6_ip}" ]] && [[ -n "${CONFIG_admin_v6_gateway}" ]]; then
  ifconfig ${SYSINFO_NIC_admin} inet6 addif ${CONFIG_admin_v6_ip} up
  admin_v6_iponly=`echo ${CONFIG_admin_v6_ip} | sed 's:/.*::'`
  route add -inet6 ${CONFIG_admin_v6_gateway} ${admin_v6_iponly} -interface
  route add -inet6 default ${CONFIG_admin_v6_gateway}
fi

exit $SMF_EXIT_OK
