#!/bin/bash

local_ip=$(ip addr show|grep global|grep eth0|awk '{print $2}'|sed 's/\/.*//')

login_ips=$(last -ai|head -n -2|awk '{print $NF}'|sed "/0.0.0.0/d;/$local_ip/d"|uniq -c|head -n 10)

login_ips_only=$(echo "$login_ips"|awk '{print $2}')

for i in $login_ips_only ; do
	login_country=$(whois "$i"|grep -m1 country | awk '{print $2}')
	if [ "$login_country"  == "CN" ]
	then
		echo "$(echo "$login_ips"|grep "$i"|head -n 1) $(curl -s "https://freeapi.ipip.net/111.34.17.246" |sed "s/,/ /g;s/[[:punct:]]//g"|tr -s " ")"
	else
	echo "$(echo "$login_ips"|grep "$i"|head -n 1) $login_country"
fi
done
