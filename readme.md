# My SmartOS configuration (global zone)

Location codes could be found on
http://www.unece.org/cefact/codesfortrade/codes_index.html

## Design

```
/opt
	/custom
		/smf
			postboot.xml
		/script
			postboot.sh
		/cfg
			/global
				/script
					00-postboot.sh
					10-ipv6.sh
				/root
					/etc
						hostname.txt
			/datacenter
				/de-fns-hetzner
					/script
					/root
						...
			/host
				/fe-cd-f0...
```

## Setup

Simple `scp` the content of one folder to `/opt/custom/`. For example:

	./deploy [hostname]
	./deploy bubbles.srv.skylime.net

## New variables for `/usbkey/config`

Fixed IPv6 support for global zone on boot:

	admin_v6_ip=
	admin_v6_gateway=

Mail configuration for SmartHost:

	mail_smarthost=
	mail_auth_user=
	mail_auth_pass=
	mail_adminaddr=
