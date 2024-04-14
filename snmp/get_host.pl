#! /usr/local/bin/perl 

   use Shell;
#   use strict;
#   use warnings;

#   use Net::SNMP;
   use SNMP::Util;

# use SNMP::Util_env;
 # Initialize mib
# &SNMP::initMib();

my %h_ifoperstatus=();
$h_ifoperstatus{"1"}="up";
$h_ifoperstatus{"2"}="down";
$h_ifoperstatus{"3"}="testing";
$h_ifoperstatus{"4"}="unknown";
$h_ifoperstatus{"5"}="dormant";
$h_ifoperstatus{"6"}="notPresent";
$h_ifoperstatus{"7"}="lowerLayerDown";
#   my $OID_sysUpTime = '1.3.6.1.2.1.1.3.0';


open(lista,"/hosts_walk/lista/h2.txt");

my @linhas=<lista>;

close(lista);

my $item="";

my ($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime(time);

my $mess=$mes+1;

my $anos=1900+$ano;

my $data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$anos,$mess,$dia_m,$hora,$min,$seg);
my $t=time();

#open(rold,"/hosts_walk/resultado/res_get.txt");

#my @lin=<rold>;

#close(rold);


my $st_old="";
my %h_st_old=();

#foreach $st_old (@lin){

#   $st_old=~s/\n//g;
#   $st_old=~s/\r//g;
#   my @ii=split(/;/,$st_old);

#   $h_st_old{$ii[12]}=$st_old;

#}

#open(resu,">/hosts_walk/resultado/tmp_res_get.txt");

foreach $item (@linhas){

#mcplt01.plt.psys;10.32.64.3;

my   @dd=split(/;/,$item);
my   $ip_host=$dd[1];
my   $host_a=$dd[0];

   if ($ip_host=~/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/){

   }
   else{

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

#cpu e memoria e temperatura

my $oid_cpuavg5min="1.3.6.1.4.1.9.2.1.58.0";
my $oid_mem_tipo="1.3.6.1.4.1.9.9.48.1.1.2";
my $oid_mem_free="1.3.6.1.4.1.9.9.48.1.1.1.5";
my $oid_mem_utl="1.3.6.1.4.1.9.9.48.1.1.1.6";

my $temperatura_nome="1.3.6.1.4.1.9.9.13.1.3.1.2";
my $temperatura_medida="1.3.6.1.4.1.9.9.13.1.3.1.3";
my $temperatura_limiar="1.3.6.1.4.1.9.9.13.1.3.1.2";
my $temperatura_status="1.3.6.1.4.1.9.9.13.1.3.1.6";

my $community="shown0cro";

my $snmp = new SNMP::Util(-device => $ip_host,
                       -community => $community, 
                       -timeout => 5,             
                       -retry => 0,             
                       -poll => 'off',            
                       -poll_timeout => 5,        
                       -verbose => 'off',         
                       -errmode => 'return',    
                       -delimiter => ' ', 
                      );

my $result = $snmp->walk_hash('v',$oid_mem_free);


my @it=keys(%result);

my $tt;
foreach $tt (@it){

print "$tt\n";
}  
 print "cpu utl 5 min: $result{$oid_mem_free}{1} \n";

@resx = $snmp->get('e',$oid_cpuavg5min);

print "$resx[0] ; $resx[1]\n";
$result2 = $snmp->walk_hash('v',$temperatura_medida);


print "#### $result2->{$temperatura_medida}{1} ####;####\n";
    if ($snmp->error){
        $error = $snmp->errmsg;
        $error_detail = $snmp->errmsg_detail;
        print "snmp error = $error\n";
        print "snmp error detail = $error_detail\n";
    }

#$snmp->close;
#my @teste_old=split(/;/,$h_st_old{$tinfo});

#my $int_status_old=$teste_old[5];
#my $int_admin_status_old=$teste_old[6];  
#my $time_old=$teste_old[0];
#my $data_old=$teste_old[1];


#   if ($int_status_old eq $h_ifoperstatus{$result->{$oid_ifstatus}} and $int_admin_status_old eq $h_ifoperstatus{$result->{$oid_ifadmin_status}}){

#      $t=$time_old; 
#      $data_reg=$data_old;
 
#   }
#   else {


#   }
#print resu "$t;$data_reg;$ip_host;$host_a;$int_a;$h_ifoperstatus{$result->{$oid_ifstatus}};";
#print resu "$h_ifoperstatus{$result->{$oid_ifadmin_status}};";
#print resu "$result->{$oid_ifInErrors};$result->{$oid_ifOutErrors};";
#print resu "$result->{$oid_ifInOctets};$result->{$oid_ifOutOctets};$result->{$oid_ifSpeed};$tinfo;\n";



}

#close (resu);
#my $sh = Shell->new;
#$sh->mv("/hosts_walk/resultado/tmp_res_get.txt","/hosts_walk/resultado/res_get.txt");
#$sh->scp("/hosts_walk/resultado/res_get.txt","root\@10.98.22.11:/fping4.0/snmp/res_get.txt");
  exit 0;
