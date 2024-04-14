#!/usr/bin/perl

use DBI();
#require "/pexe/config.pl";

$database = "noc";
$host = "10.98.22.7";
$usuario = "noc";
$senha = "noc";

my $dbh = DBI->connect
("DBI:mysql:database=$database;host=$host","$usuario", "$senha",
{'RaiseError' => 1});


open(rtti,"/hosts_walk/id_snmp/id_rtt.txt");

@rttd=<rtti>;

close(rtti);



foreach $lin (@rttd){

@dd=split(/;/,$lin);

#mcbhe01.bhe.psys_ATM1/0.722;mcbhe01;ATM1/0.722;rtt;10.32.14.1;;473;

@hh=split(/_/,$dd[0]);


$hostname=$hh[0];

$interface=$hh[1];

$ip_loop_host=$dd[4];

$id_snmp=$dd[6];


   $sql_u="";

   $sqla="select hostname,interface,ip_loopback_host,id_int";
   $sqla=$sqla." from devices";
   $sqla=$sqla." where hostname='$hostname' and interface='$interface'";
   $stfa = $dbh->prepare("$sqla");
   $stfa->execute();

   if ($stfa->rows==0){

      print "nao encontrado em a :$hostname - $interface\n";

   }
   else{

      while (($hosta,$inta,$ip_loopback_hosta,$id_inta) = $stfa->fetchrow_array){

      $sql_u="update devices set id_int='$id_snmp',ip_loopback_host='$ip_loop_host' where hostname='$hostname' and interface='$interface'";


      }

   }


#   if (length($sql_u)<5){

   $sqlb="select hostname_remoto,interface_remoto,ip_loopback_host_b,id_int_b";
   $sqlb=$sqlb." from devices";
   $sqlb=$sqlb." where hostname_remoto='$hostname' and interface_remoto='$interface'";
   $stfb = $dbh->prepare("$sqlb");
   $stfb->execute();

   if ($stfb->rows==0){

      print "nao encontrado em b :$hostname - $interface\n";

   }
   else{

      while (($hosta,$inta,$ip_loopback_hosta,$id_inta) = $stfb->fetchrow_array){

      $sql_u="update devices set id_int_b='$id_snmp',ip_loopback_host_b='$ip_loop_host' where hostname_remoto='$hostname' and interface_remoto='$interface'";


      }

   }


#   }

   if (length($sql_u)>5){


      print "$sql_u \n";

      $dbh->do($sql_u);

   }

}



exit
