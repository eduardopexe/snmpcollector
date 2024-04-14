#!/usr/bin/perl

#chama pacote DBI
use DBI();

# conexao com mysql noc idc

$database = "fping_mon";
#$host = "200.155.103.123";
$host = "10.98.22.12";
$usuario = "noc";
$senha = "noc";

my $db_i = DBI->connect
("DBI:mysql:database=$database;host=$host","$usuario", "$senha",
{'RaiseError' => 1});


$diretorio="/coleta_rttm/log_coleta";

opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);


$t=time();

($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime(time);

$mes=$mes+1;

$ano=1900+$ano;

$data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$ano,$mes,$dia_m,$hora,$min,$seg);

open(linfo,"/coleta_rttm/sumario/info_man.txt");

@status_old=<linfo>;

close(linfo);

$arql="log_".$t.".txt";

open(evlog,">/coleta_rttm/sumario/log/$arql");

#monta hash

%status_o=();
$ch="";

$vm=0;
$vd=0;
$err=0;
$adm=0;
         foreach $itemx (@status_old){

            $itemx=~s/\n//g;
            $itemx=~s/\r//g;

            @dx=split(/;/,$itemx);


            #status_o{interface}=linha de status antinga

            #print "$t;$host;$ip;$interface{$item};$if_adm{$item};$if_oper{$item};\n";

            $ch=@dx[1]."_".@dx[3];

            $status_o{$ch}=$itemx; 


         }

#fim hash status

open(linfot,">/coleta_rttm/sumario/info_man.txt");

   foreach (@pegoodir) {


      $dados = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.


      if ($dados eq '.'){next}

      if ($dados eq '..'){next}

      open (log_rtt5,"$diretorio/$dados");

      @rtt=<log_rtt5>;

      close (log_rtt5);

##################################

%interface=();

%if_adm=();

%if_oper=();

@d=split(/-/,$dados);

$ip=@d[0];

$host=@d[1];

$host=~s/\.txt//g;

$check="no check";
#################################
      foreach $linha (@rtt){

         $linha=~s/\n//g;
         $linha=~s/\r//g;
         $linha=~s/\"//g;

         #ifDescr


         if ($linha=~/ifDescr\./){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            @ins=split(/=/,$linha);

            @int=split(/\./,@ins[0]);

            $sent=~s/ //g;

            @int[1]=~s/ //g;

            $interface{@int[1]}=$sent;

         }

        #ifAdminStatus

         if ($linha=~/ifAdminStatus\./){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            @ins=split(/=/,$linha);

            @int=split(/\./,@ins[0]);

            $sent=~s/ //g;

            @int[1]=~s/ //g;

#print "@int[1] #- $sent ######3\n";
            $if_adm{@int[1]}=$sent;

         }

         #ifOperStatus

         if ($linha=~/ifOperStatus\./){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            @ins=split(/=/,$linha);

            @int=split(/\./,@ins[0]);

            $sent=~s/ //g;

            @int[1]=~s/ //g;

            $if_oper{@int[1]}=$sent;

         }


      }

         foreach $item (keys(%interface)){

$status="erro";
$cor="orange";

            if ($if_adm{$item} eq 'down(2)'){

               $status="3-administrativamente down";
               $cor="CCCCCC";
               $adm++;
            }

            if ($if_adm{$item} eq 'up(1)'){


               if ($if_oper{$item} eq 'up(1)'){

                  $status="1-up";
                  $cor="green";
                  $vd++;
               }

               if ($if_oper{$item} eq 'down(2)'){

                  $status="2-down";
                  $cor="red";
                  $vm++;
               }


            }

            if ($status eq 'erro'){

               $err++;

            }

#recuperando status antigo da interface no hash

            $chave=$host."_".$interface{$item};
#$status_o

            @sto=split(/;/,$status_o{$chave});

#compara status atual com anterior se diferente gera log

            if (@sto[6] ne $status ){

               print evlog "$t;$host;$ip;$interface{$item};$if_adm{$item};$if_oper{$item};$status;$cor;$check;$data_pol;$data_alm;$t_pol;@sto[6];\n";

               $tx=$t;
               $data_alm=$data_reg;
            }  

            if (@sto[6] eq $status ){

               $tx=@sto[0];

($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime($tx);

$mes=$mes+1;

$ano=1900+$ano;

$data_alm=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$ano,$mes,$dia_m,$hora,$min,$seg);

            }

            print linfot "$tx;$host;$ip;$interface{$item};$if_adm{$item};$if_oper{$item};$status;$cor;$check;$data_reg;$data_alm;$t;@sto[6];\n";

         }


   }


open(lgst,">/coleta_rttm/sumario/geral_web_man.txt");
print lgst "$t;$data_reg;$vd;$vm;$adm;$err;\n";

close(lgst);
close(linfot);



