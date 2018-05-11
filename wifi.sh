#!/bin/bash

if [[  $# -ne 2 ]]; then
	echo "Usage: # $(basename $0) wireless wire"
	exit 1
fi

# previous config
nmcli radio wifi off
rfkill unblock wlan
sleep 1

#Initial wifi interface configuration
ifconfig $1 up 192.168.191.1 netmask 255.255.255.0
sleep 2
#Enable NAT
iptables --flush
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain
iptables --table nat --append POSTROUTING --out-interface $2 -j MASQUERADE
iptables --append FORWARD --in-interface $1 -j ACCEPT

#Thanks to lorenzo
#Uncomment the line below if facing problems while sharing PPPoE, see lorenzo’s comment for more details
#iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

#sysctl -w net.ipv4.ip_forward=1		# already set
service isc-dhcp-server restart
sleep 2
systemctl restart hostapd		# for some reason, on Ubuntu, hostapd service not read /etc/hostapd/hostapd.conf, just change the target file
