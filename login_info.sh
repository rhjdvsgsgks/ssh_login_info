#!/bin/bash

local_ip=$(ip addr show|grep global|grep eth0|awk '{print $2}'|sed 's/\/.*//')

login_ips=$(last -ai|head -n -2|awk '{print $NF}'|sed "/0.0.0.0/d;/$local_ip/d"|uniq -c|head -n 10)

login_ips_only=$(echo "$login_ips"|awk '{print $2}')

#login_country=$(
for i in $login_ips_only ; do
	echo "$(echo "$login_ips"|grep "$i"|head -n 1) $(whois "$i"|grep -m1 country | awk '{print $2}')" ;
done
#)

