#!/bin/bash


lista=$(cat "/hosts_walk/id_snmp/id_err_host.txt")
dir="/hosts_walk/scripts"

time_out="130"
user_tacacs="ps0417"
senha_user_tacacs="600xpsys"


   for x in $lista;
        do

      ra=$(echo $x | cut -f1 -d";" )
      ip=$(echo $x | cut -f2 -d";" )

      /hosts_walk/scripts/aplica_snmp_noc.tcl $ra $ip $user_tacacs $senha_user_tacacs $time_out;

   done

rm "/hosts_walk/scripts/log/*.txt"
exit

