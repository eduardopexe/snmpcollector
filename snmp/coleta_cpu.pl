#!/usr/local/bin/perl
#ping ponto a ponto com CISCO_PING MIB
#20/10/2010
#pexe:eduardopexe@yahoo.com.br

use Socket;
use Net::SNMP;


   ####verifica se request snmp esta ok em caso de erro fecha sessao

sub ResponseCheck {

   $response = shift;

   if (!defined($response)) {
      printf("ERROR $hostname: %s\n", $session->error);
#      $session->close;
#      exit 1;
      }
   }

####################################

$arq_open="/hosts_walk/lista/hosts_snmpwalk.txt";

open(host_ping,"$arq_open");

@ping_t=<host_ping>;

close(host_ping);

   foreach $lint (@ping_t){

      $lint=~s/\n//g;
      $lint=~s/\r//g;

      #shown0cro 10.32.76.3 10.34.76.6 0A224C06 183 10 100 mcblm03.blm.psys-80-180-1 Serial0_1_0.843 2 13744
      #shown0cro 10.32.76.3 10.34.24.145 0A221891 27 10 100 mcblm03.blm.psys-110-300-1 Serial0_0_0.921 2 13860

      @dd=split(/;/,$lint);

      $community="shown0cro";
      $iploop=$dd[1];
      $hostname=$dd[0];

      ###abre sessao snmp
      if ($hostname=~/\.psys|\.cti/){


      }
      else{

         next;
      } 

      ($session, $error) = Net::SNMP->session(
                                Hostname=>$iploop,
                                #Port=>161,
                                #Version=>1,
                                Community=>$community
                                        );

       if (!defined($session))     {
           printf("ERROR: %s\n", $error);
           exit 1;
                                }

       $oid_cpuavg5min="1.3.6.1.4.1.9.2.1.58.0";
       $oid_mem_tipo="1.3.6.1.4.1.9.9.48.1.1.1.2";
       $oid_mem_free="1.3.6.1.4.1.9.9.48.1.1.1.5";
       $oid_mem_utl="1.3.6.1.4.1.9.9.48.1.1.1.6";

       $temperatura_nome="1.3.6.1.4.1.9.9.13.1.3.1.2";
       $temperatura_medida="1.3.6.1.4.1.9.9.13.1.3.1.3";
       $temperatura_limiar="1.3.6.1.4.1.9.9.13.1.3.1.4";
       $temperatura_status="1.3.6.1.4.1.9.9.13.1.3.1.6";

       $response = $session->get_request($oid_cpuavg5min);
#print "cpu\n";
       &ResponseCheck($response);
 
       $cpu5=$response->{$oid_cpuavg5min};

$t=time();
my ($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime(time);

my $mess=$mes+1;

my $anos=1900+$ano;

my $data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$anos,$mess,$dia_m,$hora,$min,$seg);

       open(tcpu0,"/hosts_walk/snmp/cpu/$hostname");
 
       @inf=<tcpu0>;

       close(tcpu0);

       open(tcpu,">/hosts_walk/snmp/cpu/$hostname");

          print tcpu "$t;$data_reg;$hostname;$cpu5;\n";


       $c=0;
       foreach $lin (@inf){

          $c++;

          print tcpu "$lin";

          if ($c>288){

             last;
          }

       }
       close(tcpu);
       ###########################################################

#       $response = $session->get_request($oid_cpuavg5min);

#       &ResponseCheck($response);

$session->close;

   }


exit
