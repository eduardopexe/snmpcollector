#!/bin/bash

ip=`cat /hosts_walk/lista/hosts_snmpwalk.txt`;
#ip=`cat /hosts_walk/lista/h2.txt`;
#IFS=" "; #IFS=" ";

for x in $ip;
do

host=$(echo $x | cut -d ";" -f 1 );
ip_host=$(echo $x | cut -d ";" -f 2 );

   rm /hosts_walk/log/*$host*

   snmpwalk -c shown0cro -v 2c $ip_host ifDescr > /hosts_walk/log/$host-$ip_host.txt & 

sleep 60;

done

perl /hosts_walk/leitor/00_ler_snmp_walk_host.pl
perl /hosts_walk/atualiza_bd/atualiza_id_snmp_rtt2.pl
/hosts_walk/scripts/00_start_cfg.sh
exit
