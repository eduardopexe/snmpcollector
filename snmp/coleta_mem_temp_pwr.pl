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

#       $response = $session->get_request($oid_cpuavg5min);
#print "cpu\n";
#       &ResponseCheck($response);
 
#       $cpu5=$response->{$oid_cpuavg5min};

$t=time();
my ($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime(time);

my $mess=$mes+1;

my $anos=1900+$ano;

my $data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$anos,$mess,$dia_m,$hora,$min,$seg);

       ####memoria
#print "mem tipo\n";
       $result = $session->get_table($oid_mem_tipo);
       &ResponseCheck($result);

       my %bla = %{$result};
#       print "\n",%bla;
       my $key;

%h_mem_nome=();

       foreach $key (keys %bla){

         #  print ($key," : ",$bla{$key},"\n");

           $troca=$oid_mem_tipo;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;

#           print ($keyi,"|||",$i," : ",$bla{$key},"\n");
           $h_mem_nome{$i}=$bla{$key}; 

       }
###########################################################
       ####memoria

       $result = $session->get_table($oid_mem_free);
#print "mem free\n";
       &ResponseCheck($result);

       my %mem_free = %{$result};
       #print "\n",%bla;
       my $key;
%h_mem_free=();

       foreach $key (keys %mem_free){

#          print ($key," : ",$mem_free{$key},"\n");

           $troca=$oid_mem_free;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;


           $h_mem_free{$i}=$mem_free{$key};

       }
###########################################################
       ####memoria

       $result = $session->get_table($oid_mem_utl);
#print "mem utl\n";
       &ResponseCheck($result);

       my %mem_utl = %{$result};
       #print "\n",%bla;
       my $key;

%h_mem_utl=();

       foreach $key (keys %mem_utl){

#          print ($key," : ",$mem_utl{$key},"\n");
 
           $troca=$oid_mem_utl;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;


           $h_mem_utl{$i}=$mem_utl{$key};  
       }
###########################################################
       ####temperatura

       $result = $session->get_table($temperatura_nome);
#print "temp nome\n";
       &ResponseCheck($result);

       my %temp_nome = %{$result};
       #print "\n",%bla;
       my $key;

%h_temp_nome=();

       foreach $key (keys %temp_nome){
#        print ($key," : ",$temp_nome{$key},"\n");

           $troca=$temperatura_nome;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;


           $h_temp_nome{$i}=$temp_nome{$key};
       }
###########################################################

       ####temperatura medida

       $result = $session->get_table($temperatura_medida);
#print "temp media\n";
       &ResponseCheck($result);

       my %temp_medida = %{$result};
       #print "\n",%bla;
       my $key;

%h_temp_medida=();

       foreach $key (keys %temp_medida){
#        print ($key," : ",$temp_medida{$key},"\n");

           $troca=$temperatura_medida;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;


           $h_temp_medida{$i}=$temp_medida{$key};
       }
###########################################################


       ####temperatura limiar

       $result = $session->get_table($temperatura_limiar);
#print "temp limiar\n";
       &ResponseCheck($result);

       my %temp_limiar = %{$result};
       #print "\n",%bla;
       my $key;

%h_temp_limiar=();

       foreach $key (keys %temp_limiar){
#        print ($key," : ",$temp_limiar{$key},"\n");

           $troca=$temperatura_limiar;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;


           $h_temp_limiar{$i}=$temp_limiar{$key};

       }
###########################################################


       ####temperatura status

       $result = $session->get_table($temperatura_status);
#print "temp status\n";
       &ResponseCheck($result);

       my %temp_status = %{$result};
       #print "\n",%bla;
       my $key;

%h_temp_status=();
       foreach $key (keys %temp_status){
#        print ($key," : ",$temp_status{$key},"\n");

           $troca=$temperatura_status;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;


           $h_temp_status{$i}=$temp_status{$key};
       }
###########################################################
       $oid_fan_nome="1.3.6.1.4.1.9.9.13.1.4.1.2";
       $oid_fan_status="1.3.6.1.4.1.9.9.13.1.4.1.3";
       $oid_pwr_nome="1.3.6.1.4.1.9.9.13.1.5.1.2";
       $oid_pwr_status="1.3.6.1.4.1.9.9.13.1.5.1.3";
###########################################################
       #### cooler (fan) e fonte status
      
       $result = $session->get_table($oid_fan_nome);
#print "mem free\n";
       &ResponseCheck($result);

       my %fan_nome = %{$result};
       #print "\n",%bla;
       my $key;
%h_fan_nome=();

       foreach $key (keys %fan_nome){

#          print ($key," : ",$mem_free{$key},"\n");

           $troca=$oid_fan_nome;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;

#print "$i ---- $fan_nome{$key} \n";
           $h_fan_nome{$i}=$fan_nome{$key};

       }
###########################################################

###########################################################
       #### cooler (fan) e fonte status
      
       $result = $session->get_table($oid_fan_status);
#print "mem free\n";
       &ResponseCheck($result);

       my %fan_status = %{$result};
       #print "\n",%bla;
       my $key;
%h_fan_status=();

       foreach $key (keys %fan_status){

#          print ($key," : ",$mem_free{$key},"\n");

           $troca=$oid_fan_status;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;

#print "$i -- status $fan_status{$key} \n";
           $h_fan_status{$i}=$fan_status{$key};

       }
###########################################################

###########################################################
       #### cooler (fan) e fonte status
      
       $result = $session->get_table($oid_pwr_nome);
#print "mem free\n";
       &ResponseCheck($result);

       my %pwr_nome = %{$result};
       #print "\n",%bla;
       my $key;
%h_pwr_nome=();

       foreach $key (keys %pwr_nome){

#          print ($key," : ",$mem_free{$key},"\n");

           $troca=$oid_pwr_nome;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;


           $h_pwr_nome{$i}=$pwr_nome{$key};

       }
###########################################################

###########################################################
       #### cooler (fan) e fonte status
      
       $result = $session->get_table($oid_pwr_status);
#print "mem free\n";
       &ResponseCheck($result);

       my %pwr_status = %{$result};
       #print "\n",%bla;
       my $key;
%h_pwr_status=();

       foreach $key (keys %pwr_status){

#          print ($key," : ",$mem_free{$key},"\n");

           $troca=$oid_pwr_status;
           $troca=~s/\./\\\./g;
           $i=$key;
           $i=~s/$troca//g;


           $h_pwr_status{$i}=$pwr_status{$key};

       }
###########################################################
  
       foreach $it (keys(%h_mem_nome)){

          $nome_mem=$h_mem_nome{$it};
          $nome_mem=~s/\//_/g;

          $nome_arq=$hostname."-".$nome_mem;

#         print "$hostname;$h_mem_nome{$it};$h_mem_free{$it};$h_mem_utl{$it};\n";
          open(tcpu0,"/hosts_walk/snmp/mem/$nome_arq");

          @inf=<tcpu0>;

          close(tcpu0);

          open(tcpu,">/hosts_walk/snmp/mem/$nome_arq");

          $mem_pct=($h_mem_utl{$it}/($h_mem_utl{$it}+$h_mem_free{$it}))*100;

          $mem_pct=sprintf("%4.2f",$mem_pct);

          print tcpu "$t;$data_reg;$hostname;$h_mem_nome{$it};$h_mem_free{$it};$h_mem_utl{$it};$mem_pct;\n";

          $c=0;
          foreach $lin (@inf){

             $c++;

             print tcpu "$lin";

             if ($c>288){

                last;
             }

          }
       close(tcpu);
      }

       foreach $it (keys(%h_temp_nome)){

#          print "$hostname;$h_temp_nome{$it};$h_temp_medida{$it};$h_temp_limiar{$it};$h_temp_status{$it};\n";

          $nome_mem=$h_temp_nome{$it};
          $nome_mem=~s/\//_/g;
          $nome_mem=~s/\\/_/g;
          $nome_mem=~s/ /_/g;
          $nome_mem=~s/\)/_/g;
          $nome_mem=~s/\(/_/g;

          $nome_arq=$hostname."-".$nome_mem;
#rint "$nome_arq\n";

          open(tcpu0,"/hosts_walk/snmp/temp/$nome_arq");
  
          @inf=<tcpu0>;

          close(tcpu0);

          open(tcpu,">/hosts_walk/snmp/temp/$nome_arq");


          print tcpu "$t;$data_reg;$hostname;$h_temp_nome{$it};$h_temp_medida{$it};$h_temp_limiar{$it};$h_temp_status{$it};\n";


          $c=0;
          foreach $lin (@inf){

             $c++;

             print tcpu "$lin";

             if ($c>288){

                last;
             }

          }

          close(tcpu);


       }

          $nome_arq=$hostname."_fan";
#rint "$nome_arq\n";

          open(tcpu0,"/hosts_walk/snmp/fan/$nome_arq");

          @inf=<tcpu0>;

          close(tcpu0);

          open(tcpu,">/hosts_walk/snmp/fan/$nome_arq");

          print tcpu "$t;$data_reg;$hostname;";


       foreach $it (sort(keys(%h_fan_nome))){

#          print "$hostname;$h_temp_nome{$it};$h_temp_medida{$it};$h_temp_limiar{$it};$h_temp_status{$it};\n";

          $nome_mem=$h_fan_nome{$it};
          $nome_mem=~s/\//_/g;
          $nome_mem=~s/\\/_/g;
          $nome_mem=~s/ /_/g;
          $nome_mem=~s/\)/_/g;
          $nome_mem=~s/\(/_/g;

#print "fan_nome $it\n";

          print tcpu "$h_fan_nome{$it};$h_fan_status{$it};";


       }

         print tcpu "\n";

          $c=0;

          foreach $lin (@inf){

             $c++;

             print tcpu "$lin";

             if ($c>288){

                last;
             }

          }

          close(tcpu);

#################################################################

          $nome_arq=$hostname."_pwr";
#rint "$nome_arq\n";

          open(tcpu0,"/hosts_walk/snmp/pwr/$nome_arq");

          @inf=<tcpu0>;

          close(tcpu0);

          open(tcpu,">/hosts_walk/snmp/pwr/$nome_arq");

          print tcpu "$t;$data_reg;$hostname;";


       foreach $it (sort(keys(%h_pwr_nome))){

#          print "$hostname;$h_temp_nome{$it};$h_temp_medida{$it};$h_temp_limiar{$it};$h_temp_status{$it};\n";

          $nome_mem=$h_pwr_nome{$it};
          $nome_mem=~s/\//_/g;
          $nome_mem=~s/\\/_/g;
          $nome_mem=~s/ /_/g;
          $nome_mem=~s/\)/_/g;
          $nome_mem=~s/\(/_/g;

          print tcpu "$h_pwr_nome{$it};$h_pwr_status{$it};";


       }

         print tcpu "\n";

          $c=0;

          foreach $lin (@inf){

             $c++;

             print tcpu "$lin";

             if ($c>288){

                last;
             }

          }

          close(tcpu);

#################################################################

   }



exit
