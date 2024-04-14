#!/bin/bash

ip=`cat /hosts_walk/lista/hosts_snmpwalk.txt`;

#ip=`cat /hosts_walk/lista/h2.txt`;

oid_cpuavg5min="1.3.6.1.4.1.9.2.1.58.0";
oid_mem_tipo="1.3.6.1.4.1.9.9.48.1.1.1.2";
oid_mem_free="1.3.6.1.4.1.9.9.48.1.1.1.5";
oid_mem_utl="1.3.6.1.4.1.9.9.48.1.1.1.6";

temperatura_nome="1.3.6.1.4.1.9.9.13.1.3.1.2";
temperatura_medida="1.3.6.1.4.1.9.9.13.1.3.1.3";
temperatura_limiar="1.3.6.1.4.1.9.9.13.1.3.1.4";
temperatura_status="1.3.6.1.4.1.9.9.13.1.3.1.6";

for x in $ip;
do

host=$(echo $x | cut -d ";" -f 1 );
ip_host=$(echo $x | cut -d ";" -f 2 );

        ping $ip_host -w2 -c2 >> /dev/null

        if [ $? = 0 ]; then

   rm /hosts_walk/log_coleta/*$host*

   echo "### cpu" > /hosts_walk/log_coleta/$host-$ip_host.txt 
   snmpwalk -c shown0cro -v 2c $ip_host $oid_cpuavg5min >> /hosts_walk/log_coleta/$host-$ip_host.txt 

   echo "### mem tipo" >> /hosts_walk/log_coleta/$host-$ip_host.txt 
   snmpwalk -c shown0cro -v 2c $ip_host $oid_mem_tipo >> /hosts_walk/log_coleta/$host-$ip_host.txt 

   echo "### mem free" >> /hosts_walk/log_coleta/$host-$ip_host.txt 
   snmpwalk -c shown0cro -v 2c $ip_host $oid_mem_free >> /hosts_walk/log_coleta/$host-$ip_host.txt 

   echo "### mem utl" >> /hosts_walk/log_coleta/$host-$ip_host.txt 
   snmpwalk -c shown0cro -v 2c $ip_host $oid_mem_utl >> /hosts_walk/log_coleta/$host-$ip_host.txt 

#   echo "### temperatura" >> /hosts_walk/log_coleta/$host-$ip_host.txt 
#   snmpwalk -c shown0cro -v 2c $ip_host $temperatura_nome >> /hosts_walk/log_coleta/$host-$ip_host.txt 

#   echo "### temperatura medida" >> /hosts_walk/log_coleta/$host-$ip_host.txt 
#   snmpwalk -c shown0cro -v 2c $ip_host $temperatura_medida >> /hosts_walk/log_coleta/$host-$ip_host.txt 

#   echo "### temperatura_limiar" >> /hosts_walk/log_coleta/$host-$ip_host.txt 
#   snmpwalk -c shown0cro -v 2c $ip_host $temperatura_limiar >> /hosts_walk/log_coleta/$host-$ip_host.txt 

#   echo "### temperatura_status" >> /hosts_walk/log_coleta/$host-$ip_host.txt 
#   snmpwalk -c shown0cro -v 2c $ip_host $temperatura_status >> /hosts_walk/log_coleta/$host-$ip_host.txt 

   perl  /hosts_walk/leitor/leitor_cpu_mem.pl $host-$ip_host.txt 
#sleep 60;
   fi

done

#perl /hosts_walk/leitor/00_ler_snmp_walk_host.pl

exit


