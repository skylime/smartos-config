# My SmartOS configuration (global zone)

Location codes could be found on
http://www.unece.org/cefact/codesfortrade/codes_index.html

## Setup

Simple `scp` the content of one folder to `/opt/custom/`. For example:

	./deploy [folder] [hostname]
	./deploy de-muc-ipx bubbles.srv.skylime.net

## New variables for `/usbkey/config`

Fixed IPv6 support for global zone on boot:

	admin_v6_ip=
	admin_v6_gateway=

Mail configuration for SmartHost:

	mail_smarthost=
	mail_auth_user=
	mail_auth_pass=
	mail_adminaddr=
