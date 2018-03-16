# SmartOS configuration (global zone)

In this repository you will find some `postboot` scripts for our SmartOS
installations. This will allow you to run bash-scripts, deploy cfg files
based on the datacenter (location) or hostname.

## Datacenter codes

We use the following datacenter code for our hosts:

	<country>-<location code>-<provider>
	
The location code could be found on the website from UNECE:

	http://www.unece.org/cefact/codesfortrade/codes_index.html

## Folder structure

```
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

Fixed IPv6 support for global zone on boot ([NIC syntax](http://wiki.smartos.org/display/DOC/extra+configuration+options#extraconfigurationoptions-AdditionalNICs)):

	admin0_v6_ip=
	admin0_v6_gateway=

**NOTE**: The instance# is necessary for this script to work properly

Mail configuration for SmartHost, everything is optional:

	mail_smarthost=
	mail_smarthost_port=
	mail_sender_domain=
	mail_auth_user=
	mail_auth_pass=
	mail_adminaddr=
