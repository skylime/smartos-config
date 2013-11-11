#!/bin/ksh

hostname=${1}

## Disable DAD for Solaris
## http://wiki.hetzner.de/index.php/Solaris_DAD 
# IPv4
/sbin/ipadm set-prop  -p _arp_probe_count=0 ip
/sbin/ipadm set-prop  -p _arp_fastprobe_count=0 ip
/sbin/ipadm set-prop  -p _arp_defend_interval=0 ip
# IPv6
/sbin/ipadm set-prop  -p _dad_announce_interval=0 ipv4
/sbin/ipadm set-prop  -p _dad_announce_interval=0 ipv6
/sbin/ipadm set-prop  -p _ndp_defend_interval=0 ip
/sbin/ipadm set-prop  -p _ndp_defend_rate=0 ip
# Result
/sbin/ipadm show-prop -p _arp_probe_count ip

## Global zone setup - nat and virtual setup
# create virtual network device in switch0
dladm create-vnic -l switch0 vnic0
# assign to global zone
ifconfig vnic0 plumb
ifconfig vnic0 inet6 plumb up
# setup ip and network
ifconfig vnic0 inet 192.168.200.1 up
ifconfig vnic0 inet6 addif 2a01:4f8:150:3ffb::1/64 up
# enable ipv4 forwarding
routeadm -u -e ipv4-forwarding
# enable ipv6 forwarding
routeadm -u -e ipv6-forwarding
# setup nat rules
cp /opt/custom/conf/${hostname}/ipf.conf /etc/ipf/ipf.conf
cp /opt/custom/conf/${hostname}/ipnat.conf /etc/ipf/ipnat.conf
# enable ipfilter
svcadm enable network/ipfilter
# reload
#ipf -Fa -f /etc/ipf/ipf.conf
#ipnat -C -f /etc/ipf/ipnat.conf

## Copy svc methods
# openvpn start script
cp /opt/custom/script/${hostname}/openvpn /lib/svc/method/openvpn
