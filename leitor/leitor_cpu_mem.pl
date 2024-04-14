#!/usr/bin/perl


#chama pacote DBI
#use DBI();

# conexao com mysql noc idc

#$database = "fping_mon";
#$host = "200.155.103.123";
#$host = "10.98.22.12";
#$usuario = "noc";
#$senha = "noc";

#my $db_i = DBI->connect
#("DBI:mysql:database=$database;host=$host","$usuario", "$senha",
#{'RaiseError' => 1});


$diretorio="/hosts_walk/log_coleta";

#opendir (MEUDIR, "$diretorio");
#@pegoodir = readdir(MEUDIR);
#closedir (MEUDIR);


$t=time();

%cpuavg5=();
%mem_nome=();
%mem_free=();
%mem_util=();

%temp_nome=();
%temp_medido=();
%temp_limiar=();
%temp_status=();

%cpu_avg_old=();
%mem_pct_old=();
%mem_free_old=();
%mem_util_old=();
%temp_status_old=();
%temp_limiar_old=();
%temp_medido_old=();

#   foreach (@pegoodir) {


#      $dados = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.


#      if ($dados eq '.'){next}

#      if ($dados eq '..'){next}

$dados=@ARGV[0];

#print "open $diretorio/$dados\n";
      open (log_rtt5,"$diretorio/$dados");

      @rtt=<log_rtt5>;

      close (log_rtt5);

##################################


@d=split(/-/,$dados);

$ip=@d[1];

$host=@d[0];

$ip=~s/\.txt//g;

$cpu5="";
###############################
###coleta status anterior

      open(hold,"/hosts_walk/www/hist_cpu_mem/$host");

      @coleta=<hold>;

      close(hold);

         foreach $clt (@coleta){

            $clt=~s/\n//g;
            @dados=split(/;/,$clt);

      ###################### temp medido

            if ($clt=~/;temp medido;/){

            $ref=$dados[2];
      
            $conta=0;
            $vref=""; 
               foreach $cl (@dados){

                  if ($conta>65){

                     last;
                  }

                  if ($conta>4){

                     $vref=$vref."$cl".";";

                  }

                  $conta++;  
               }

               $temp_medido_old{$ref}=$vref;
            }

      
################ fim temp medido

###################### temp limiar

            if ($clt=~/;temp limiar;/){

            $ref=$dados[2];
      
            $conta=0;
            $vref=""; 
               foreach $cl (@dados){

                  if ($conta>65){

                     last;
                  }

                  if ($conta>4){

                     $vref=$vref."$cl".";";

                  }

                  $conta++;  
               }

               $temp_limiar_old{$ref}=$vref;
            }

      
################ fim temp limiar


###################### temp status
            if ($clt=~/;temp status;/){

            $ref=$dados[2];
      
            $conta=0;
            $vref=""; 
               foreach $cl (@dados){

                  if ($conta>65){

                     last;
                  }

                  if ($conta>4){

                     $vref=$vref."$cl".";";

                  }

                  $conta++;  
               }

               $temp_status_old{$ref}=$vref;
            }

      
################ fim temp status

###################### mem free
            if ($clt=~/;mem_free;/){

            $ref=$dados[2];
      
            $conta=0;
            $vref=""; 
               foreach $cl (@dados){

                  if ($conta>65){

                     last;
                  }

                  if ($conta>4){

                     $vref=$vref."$cl".";";

                  }

                  $conta++;  
               }

               $mem_free_old{$ref}=$vref;
            }

      
################ fim mem free

###################### mem util
            if ($clt=~/;mem_util;/){

            $ref=$dados[2];
      
            $conta=0;
            $vref=""; 
               foreach $cl (@dados){

                  if ($conta>65){

                     last;
                  }

                  if ($conta>4){

                     $vref=$vref."$cl".";";

                  }

                  $conta++;  
               }

               $mem_util_old{$ref}=$vref;
            }

      
################ fim mem util

###################### mem pct
            if ($clt=~/;pct_util;/){

            $ref=$dados[2];
      
            $conta=0;
            $vref=""; 
               foreach $cl (@dados){

                  if ($conta>65){

                     last;
                  }

                  if ($conta>4){

                     $vref=$vref."$cl".";";

                  }

                  $conta++;  
               }

               $mem_pct_old{$ref}=$vref;
            }

      
################ fim mem pct

###################### cpu
            if ($clt=~/;cpu avg;/){

            $ref=$dados[2];
      
            $conta=0;
            $vref=""; 
               foreach $cl (@dados){

                  if ($conta>65){

                     last;
                  }

                  if ($conta>4){

                     $vref=$vref."$cl".";";

                  }

                  $conta++;  
               }

               $cpu_avg_old{$ref}=$vref;
            }

      
################ fim cpu


         }


##### fim coleta status anterior

#########################

      foreach $linha (@rtt){

         $linha=~s/\n//g;
         $linha=~s/\r//g;
         $linha=~s/\"//g;


         #cpu 5 min

         if ($linha=~/enterprises\.9\.2\.1\.58\.0/){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            $cpu5=$sent;
            $cpu5=~s/ //g;

            $cpuavg5{$host}=$cpu5;
        }

         #mem nome

         if ($linha=~/enterprises\.9\.9\.48\.1\.1\.1\.2\./){

            $linha=~s/enterprises\.9\.9\.48\.1\.1\.1\.2\./:/g;
            $linha=~s/ = /:/g;

            @sent=split(/:/,$linha);

            $id=$sent[3];
            $sent=$sent[5];
            $ref=$host."_".$id;
            $sent=~s/ //g;
            $mem_nome{$ref}=$sent;
         }
         #mem utilizada

         if ($linha=~/enterprises\.9\.9\.48\.1\.1\.1\.5\./){

            $linha=~s/enterprises\.9\.9\.48\.1\.1\.1\.5\./:/g;
            $linha=~s/ = /:/g;

            @sent=split(/:/,$linha);

            $id=$sent[3];
            $sent=$sent[5];
            $ref=$host."_".$id;
            $sent=~s/ //g;
            $mem_util{$ref}=$sent;
         }

         #mem free

         if ($linha=~/enterprises\.9\.9\.48\.1\.1\.1\.6\./){

            $linha=~s/enterprises\.9\.9\.48\.1\.1\.1\.6\./:/g;
            $linha=~s/ = /:/g;

#print "$linha \n";
            @sent=split(/:/,$linha);

            $id=$sent[3];
            $sent=@sent[5];
            $sent=~s/ //g;
            $ref=$host."_".$id;
            $sent=~s/ //g;
            $mem_free{$ref}=$sent;
         }

         #temperatura nome

         if ($linha=~/enterprises\.9\.9\.13\.1\.3\.1\.2\./){

            $linha=~s/enterprises\.9\.9\.13\.1\.3\.1\.2\./:/g;
            $linha=~s/ = /:/g;

            @sent=split(/:/,$linha);

            $id=$sent[3];
            $sent=$sent[5];
            $ref=$host."_".$id;
            $sent=~s/ //g;
            $temp_nome{$ref}=$sent;
         }


         #temperatura medida

         if ($linha=~/enterprises\.9\.9\.13\.1\.3\.1\.3\./){

            $linha=~s/enterprises\.9\.9\.13\.1\.3\.1\.3\./:/g;
            $linha=~s/ = /:/g;

            @sent=split(/:/,$linha);

            $id=$sent[3];
            $sent=$sent[5];
            $ref=$host."_".$id;
            $sent=~s/ //g;
            $temp_medido{$ref}=$sent;
         }


         #temperatura limiar
         if ($linha=~/enterprises\.9\.9\.13\.1\.3\.1\.4\./){

            $linha=~s/enterprises\.9\.9\.13\.1\.3\.1\.4\./:/g;
            $linha=~s/ = /:/g;

            @sent=split(/:/,$linha);

            $id=$sent[3];
            $sent=$sent[5];
            $ref=$host."_".$id;
            $sent=~s/ //g;
            $temp_limiar{$ref}=$sent;
         }


         #temperatura status
         if ($linha=~/enterprises\.9\.9\.13\.1\.3\.1\.6\./){

            $linha=~s/enterprises\.9\.9\.13\.1\.3\.1\.6\./:/g;
            $linha=~s/ = /:/g;

            @sent=split(/:/,$linha);

            $id=$sent[3];
            $sent=$sent[5];
            $ref=$host."_".$id;
            $sent=~s/ //g;
            $temp_status{$ref}=$sent;
#print "temp_status $ref -- $sent\n";
         }

      }



#   }

%mem_host=();
###pct memoria processador host
%mem_proc=();

### pct memoria io host
%mem_io=();

%mem_status=();

         foreach $item (keys(%mem_nome)){

            @hh=split(/\_/,$item);

            
            $utl_mem=($mem_util{$item}/($mem_free{$item}+$mem_util{$item}))*100;
            $utl_mem=int($utl_mem);
            $memn=$mem_host{$hh[0]};           
            $memn=$memn."$t;$hh[0];$item;mem_free;$mem_nome{$item};$mem_free{$item};$mem_free_old{$item}\n";
            $memn=$memn."$t;$hh[0];$item;mem_util;$mem_nome{$item};$mem_util{$item};$mem_util_old{$item}\n";
            $memn=$memn."$t;$hh[0];$item;pct_util;$mem_nome{$item};$utl_mem;$mem_pct_old{$item}\n";

            $mem_host{$hh[0]}=$memn;

            if ($utl_mem>80){

               $mem_status{$hh[0]}=$mem_status{$hh[0]}.":".$mem_nome{$item}.":alarme mem: $utl_mem | ";           
            }


            if ($mem_nome{$item}=~/Proc/){

               $mem_proc{$hh[0]}=$utl_mem;

            }

            if ($mem_nome{$item}=~/I\/O|io|Fast|fast/){

               $mem_io{$hh[0]}=$utl_mem;

            }
#            print "$item;$mem_nome{$item};$mem_free{$item};$mem_util{$item}\n";

         }

%temp_host=();

%temp_statush=();
%temp_pct=();
%temp_maior=();

         foreach $item (keys(%temp_nome)){

            @hh=split(/\_/,$item);

            $tempn=$temp_host{$hh[0]};
            $tempn=$tempn."$t;$hh[0];$item;temp medido;$temp_nome{$item};$temp_medido{$item};$temp_medido_old{$item}\n";
            $tempn=$tempn."$t;$hh[0];$item;temp limiar;$temp_nome{$item};$temp_limiar{$item};$temp_limiar_old{$item}\n";
            $tempn=$tempn."$t;$hh[0];$item;temp status;$temp_nome{$item};$temp_status{$item};$temp_status_old{$item}\n";

            $temp_host{$hh[0]}=$tempn;

            if ($temp_medido{$item}>0){

               $temp_p=$temp_limiar{$item}/$temp_medido{$item};

            }

#print "$temp_p $item $hh[0]\n";

            if(length($temp_pct{$hh0}<1)){

                  $temp_pct{$hh0}=$temp_p;
                  $temp_maior{$hh[0]}=$temp_nome{$item}.";".$temp_medido{$item};


            }
            else{
               if ($temp_p<$temp_pct{$hh0}){
 
                  $temp_pct{$hh0}=$temp_p;
                  $temp_maior{$hh[0]}=$temp_nome{$item}.";".$temp_medido{$item};

               }
            }
#print "$temp_status{$item} | $item \n";

            if($temp_status{$item}=~/1|4|5/){

               $st="ok";

            }

            if($temp_status{$item} eq '2'){

               $st="alarme";

            }

            if($temp_status{$item} eq '3'){

               $st="critico";

            }

            if($temp_status{$item} eq '6'){

               $st="nao funciona";

            }

            if ($st ne 'ok'){

               $temp_statush{$hh[0]}=$temp_statush{$hh[0]}.$temp_nome{$item}.":".$st.":";

            }            
         #   print "$item;\n";

         }


         foreach $item (keys(%cpuavg5)){

         $arq=$item;
         open ($arq,">/hosts_walk/www/hist_cpu_mem/$arq");

            if ($cpuavg5{$item}==0){

               $st_cpu="nao coletou";
            }

            if ($cpuavg5{$item}<31){

               $st_cpu="cpuok";
            }

            if ($cpuavg5{$item}>30){

               $st_cpu="alarmecpu1";
            }

            if ($cpuavg5{$item}>60){

               $st_cpu="alarmecpu2";
            }

            if ($cpuavg5{$item}>90){

               $st_cpu="criticocpu1";
            }             

            if ($cpuavg5{$item}>95){

               $st_cpu="criticocpu2";
            }       

            if (length($temp_statush{$item})<3){

               $st_temp="ok;".$temp_maior{$item};

            }
            else{

               $st_temp="alarme;".$temp_statush{$item};

            }

            if (length($mem_status{$item})<3){

               $st_mem="mem ok;".$mem_io{$item}.";".$mem_proc{$item};

            }
            else{

               $st_mem="alarme mem;".$mem_status{$item}.";".$mem_io{$item}.";".$mem_proc{$item};

            }

            $cpn="$t;$data_reg;$item;$cpuavg5{$item};$st_cpu;$st_mem;\n";

            $cpn=$cpn."$t;$item;$item;cpu avg;cpu avg;$cpuavg5{$item};$cpu_avg_old{$item};\n";
#            $cpn=$cpn."$temp_host{$item}";
            $cpn=$cpn."$mem_host{$item}";

            print $arq "$cpn";

         close($arq);
        }

exit
