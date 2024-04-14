#!/usr/local/bin/perl

use Shell;
#gera sumario cpu
my $sh = Shell->new;

$diretorio="/hosts_walk/snmp/mem/";

opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);

open(memproc,">/hosts_walk/snmp/sum/sum_mem_proc.txt");
open(memtr,">/hosts_walk/snmp/sum/sum_mem_tr.txt");
open(memio,">/hosts_walk/snmp/sum/sum_mem_io.txt");
open(memdr,">/hosts_walk/snmp/sum/sum_mem_driver.txt");

   foreach (@pegoodir) {


      $dados = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.


      if ($dados eq '.'){next}

      if ($dados eq '..'){next}

      open (log_cpu5,"$diretorio/$dados");

      @rttx=<log_cpu5>;


      @info_a=lstat(log_cpu5);

      close (log_cpu5);

      $t=time();

      $ta=@info_a[9];

      $dif=$t-$ta;

      if ($dif>3599){

          print "$dados | $t | $ta |--- $dif \n";
          $sh->rm("$diretorio/$dados");
          next;

      }

$saida="memproc";

      if ($dados=~/Processor/){

         $saida="memproc";

      }

      if ($dados=~/I_O|io/){

         $saida="memio";

      }

      if ($dados=~/Transient/){

         $saida="memtr";

      }

      if ($dados=~/Driver|driver/){

         $saida="memdr";

      }

      foreach $linha (@rttx){

         print $saida "$linha";

         last;

      }

}

close(memproc);
close(memtr);
close(memio);
close(memdr);
exit

