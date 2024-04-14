#! /usr/local/bin/perl 

   use Shell;
#   use strict;
#   use warnings;

   use Net::SNMP;

my %h_ifoperstatus=();
$h_ifoperstatus{"1"}="up";
$h_ifoperstatus{"2"}="down";
$h_ifoperstatus{"3"}="testing";
$h_ifoperstatus{"4"}="unknown";
$h_ifoperstatus{"5"}="dormant";
$h_ifoperstatus{"6"}="notPresent";
$h_ifoperstatus{"7"}="lowerLayerDown";
#   my $OID_sysUpTime = '1.3.6.1.2.1.1.3.0';


open(lista,"/hosts_walk/id_snmp/id_getsnmp.txt");

my @linhas=<lista>;

close(lista);

my $item="";

my ($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime(time);

my $mess=$mes+1;

my $anos=1900+$ano;

my $data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$anos,$mess,$dia_m,$hora,$min,$seg);
my $t=time();

open(rold,"/hosts_walk/resultado/res_get.txt");

my @lin=<rold>;

close(rold);


my $st_old="";
my %h_st_old=();

foreach $st_old (@lin){

   $st_old=~s/\n//g;
   $st_old=~s/\r//g;
   my @ii=split(/;/,$st_old);

   $h_st_old{$ii[12]}=$st_old;

}

open(resu,">/hosts_walk/resultado/tmp_res_get.txt");

foreach $item (@linhas){


my   @dd=split(/;/,$item);
my   $ip_host=$dd[5];
my   $host_a=$dd[1];
my   $int_a=$dd[2];
my   $id_int=$dd[6];
my   $tinfo=$dd[0];

   if ($ip_host=~/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/ and $id_int=~/[0-9]/){

   }
   else{
#print "$item - $ip_host ! $id_int $host_a $int_a $tinfo\n";
#mcpae03.pae.psys_Serial4/4:0;mcpae03;Serial4/4:0;rtt;10.32.16.4;snmpa;482;

my @hx=split(/_/,$dd[0]);

$ip_host=$dd[4];
$host_a=$hx[0];
$int_a=$dd[2];
$id_int=$dd[6];
$tinfo=$dd[0];

print "$host_a $ip_host\n";
   }

   if ($ip_host=~/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/ and $id_int=~/[0-9]/){

   }
   else{

print "$item - $ip_host ! $id_int $host_a $int_a $tinfo\n";
   next;

   }
my   $oid_ifstatus="1.3.6.1.2.1.2.2.1.8.".$id_int;
my   $oid_ifadmin_status="1.3.6.1.2.1.2.2.1.7.".$id_int;
my $oid_ifLastChange="1.3.6.1.2.1.2.2.1.9.".$id_int;
my $oid_ifInOctets="1.3.6.1.2.1.2.2.1.10.".$id_int;
my $oid_ifInErrors="1.3.6.1.2.1.2.2.1.14.".$id_int;
my $oid_ifOutOctets="1.3.6.1.2.1.2.2.1.16.".$id_int;
my $oid_ifOutErrors="1.3.6.1.2.1.2.2.1.20.".$id_int;
my $oid_ifSpeed="1.3.6.1.2.1.2.2.1.5.".$id_int;
my @oids=($oid_ifstatus,$oid_ifadmin_status,$oid_ifLastChange,$oid_ifInErrors,$oid_ifOutErrors,$oid_ifSpeed,$oid_ifInOctets,$oid_ifOutOctets);

#print "###@oids[0]#";
my ($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime(time);

my $mess=$mes+1;

my $anos=1900+$ano;

my $data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$anos,$mess,$dia_m,$hora,$min,$seg);
$t=time();

   my ($session, $error) = Net::SNMP->session(
      -hostname  => shift || "$ip_host",
      -community => shift || 'shown0cro',
      -version   => '2',
   );

   if (!defined $session) {
      printf "ERROR: %s.\n", $error;
      exit 1;
   }

   my $result = $session->get_request(-varbindlist => [ @oids ],);

   if (!defined $result) {
      printf "ERROR: %s.\n", $session->error();
      $session->close();
      exit 1;
   }

my @teste_old=split(/;/,$h_st_old{$tinfo});

my $int_status_old=$teste_old[5];
my $int_admin_status_old=$teste_old[6];  
my $time_old=$teste_old[0];
my $data_old=$teste_old[1];


   if ($int_status_old eq $h_ifoperstatus{$result->{$oid_ifstatus}} and $int_admin_status_old eq $h_ifoperstatus{$result->{$oid_ifadmin_status}}){

      $t=$time_old; 
      $data_reg=$data_old;
 
   }
   else {


   }
print resu "$t;$data_reg;$ip_host;$host_a;$int_a;$h_ifoperstatus{$result->{$oid_ifstatus}};";
print resu "$h_ifoperstatus{$result->{$oid_ifadmin_status}};";
print resu "$result->{$oid_ifInErrors};$result->{$oid_ifOutErrors};";
print resu "$result->{$oid_ifInOctets};$result->{$oid_ifOutOctets};$result->{$oid_ifSpeed};$tinfo;\n";

#print  "$t;$data_reg;$ip_host;$host_a;$int_a;$h_ifoperstatus{$result->{$oid_ifstatus}};";
#print  "$h_ifoperstatus{$result->{$oid_ifadmin_status}};";
#print  "$result->{$oid_ifInErrors};$result->{$oid_ifOutErrors};";
#print  "$result->{$oid_ifInOctets};$result->{$oid_ifOutOctets};$result->{$oid_ifSpeed};$tinfo;\n";

#print resu "$h_ifoperstatus{$result->{$oid_ifadmin_status}};";

#   printf "$ip_host \n operstatus::::". $result->{$oid_ifstatus};

#   print "$h_ifoperstatus{$result->{$oid_ifstatus}} \n";
#   print "\n admin status :::::::::::". $result->{$oid_ifadmin_status};

#   print "\n in errs ".$result->{$oid_ifInErrors};
#   print "\n out errs ".$result->{$oid_ifOutErrors};

#   print "\n trafego in ".$result->{$oid_ifInOctets};

#   print "\n trafego out ".$result->{$oid_ifOutOctets};

#   print "\n speed ".$result->{$oid_ifSpeed};
#   print "\n";
#foreach $item (keys(%s)){

#print "$item -- $s{$item} \n";

#}
   $session->close();

}

close (resu);
my $sh = Shell->new;
$sh->mv("/hosts_walk/resultado/tmp_res_get.txt","/hosts_walk/resultado/res_get.txt");
$sh->scp("/hosts_walk/resultado/res_get.txt","root\@10.98.22.11:/fping4.0/snmp/res_get.txt");
  exit 0;
