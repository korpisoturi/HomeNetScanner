#!/bin/bash
#home network scan version 1.0.6, 1.10.2017 nmap
#defining folder V 1.0.5

FOLDER="/home/pi/netskanner"

#identify host's LAN IPv4 address v 1.0.0
LAN=$(sudo ifconfig|grep Bcast|cut -d":" -f2|cut -d" " -f1)

#identify the subnet mask, can be /24 or smaller v 1.0.2
MASK=$(sudo ifconfig|grep Bcast|cut -d":" -f4|cut -d"." -f4)
D2B=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1})
ARVO=${D2B[$MASK]} ARVO=$(echo $ARVO | cut -d"0" -f1 | wc -c)
MASK=$((23+$ARVO))

#scan all possible LAN IP address' and write a sorted list of identified IPs and MACs v 1.0.0
sudo nmap -sP $LAN/$MASK|awk '/Nmap scan report for/{printf $5;}/MAC Address:/{print " " tolower ($3);}'|sort -V > $FOLDER/nmap.list

#this list still miss scanner host's MAC address get the host IP and MAC and add it to correct place in the list v 1.0.1
ownIP=$(sudo ifconfig|grep Bcast|cut -d":" -f2|cut -d" " -f1)
ownMAC=$(sudo ifconfig|grep HWaddr|cut -d" " -f11)
sed -i 's/\b'"$ownIP"'\b/&'" $ownMAC"'/' $FOLDER/nmap.list
