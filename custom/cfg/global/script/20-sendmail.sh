#!/usr/bin/bash

## Load configuration information from USBKey
. /lib/svc/share/smf_include.sh
. /lib/sdc/config.sh

load_sdc_sysinfo
load_sdc_config

## Set the PATH environment because of other commands in /usr
PATH=/usr/bin:/usr/sbin:${PATH}

## Initialize sendmail configuration change counter
SM_CHANGED=0

## Sendmail configuration for SmartHost setup
if [[ ${CONFIG_mail_smarthost} ]]; then
	cp /etc/mail/{submit,sendmail}.cf /tmp/
	sed -i "s:^DS$:DS[${CONFIG_mail_smarthost}]:g" /tmp/{submit,sendmail}.cf
	let SM_CHANGED++
	## Sendmail relay port (ex 587)
	if [[ ${CONFIG_mail_smarthost_port} ]]; then
		sed -i "/^Mrelay/,+2 s:\(A=TCP \$h\)$:\1 ${CONFIG_mail_smarthost_port}:" /tmp/{submit,sendmail}.cf
	fi
fi

## Possibility to modify the sender domain name, default FQDN
if [[ ${CONFIG_mail_sender_domain} ]]; then
	if [[ $SM_CHANGED -eq 0 ]]; then
		cp /etc/mail/{submit,sendmail}.cf /tmp/
	fi
	sed -i "s:#Dj.*:Dj${CONFIG_mail_sender_domain}:g" /tmp/{submit,sendmail}.cf
	let SM_CHANGED++
fi

if [[ ${CONFIG_mail_auth_user} ]]; then
	echo 'AuthInfo:'${CONFIG_mail_smarthost}' "U:'${CONFIG_mail_auth_user}'" "I:'${CONFIG_mail_auth_user}'" "P:'${CONFIG_mail_auth_pass}'"' \
		> /etc/mail/default-auth-info
	echo -e 'Kauthinfo hash /etc/mail/default-auth-info
O AuthMechanisms=EXTERNAL GSSAPI DIGEST-MD5 CRAM-MD5 LOGIN PLAIN
Sauthinfo
R$*\t\t\t$: <$(authinfo AuthInfo:$&{server_name} $: ? $)>
R<?>\t\t$: <$(authinfo AuthInfo:$&{server_addr} $: ? $)>
R<?>\t\t$: <$(authinfo AuthInfo: $: ? $)>
R<?>\t\t$@ no               no authinfo available
R<$*>\t\t$# $1' \
	| tee -a /etc/mail/sendmail.cf >> /etc/mail/submit.cf
	makemap hash /etc/mail/default-auth-info < /etc/mail/default-auth-info
	chgrp smmsp /etc/mail/default-auth-info.db
fi

## Redirect all root emails to admin address
if [[ ${CONFIG_mail_adminaddr} ]]; then
	echo "root: ${CONFIG_mail_adminaddr}" >> /etc/mail/aliases
	newaliases
fi

if [[ $SM_CHANGED -gt 0 ]]; then
	## Merge and clean up temporary files
	for f in {submit,sendmail}.cf; do
		cat /tmp/${f} > /etc/mail/${f}
		rm /tmp/${f}
	done

	## Refresh the configuration
	svcadm refresh sendmail{,-client}
fi

exit $SMF_EXIT_OK
