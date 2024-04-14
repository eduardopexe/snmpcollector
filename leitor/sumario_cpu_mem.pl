#!/usr/bin/perl

use Shell;

$diretorio="/hosts_walk/www/hist_cpu_mem";

opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);

open(sum,">/hosts_walk/resultado/sumario_cpu_mem.txt");

   foreach (@pegoodir) {


      $dados = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.


      if ($dados eq '.'){next}

      if ($dados eq '..'){next}

      open (log_cpu5,"$diretorio/$dados");

      @rttx=<log_cpu5>;

      close (log_rtt5);

#      $l=0;

      foreach $linha (@rttx){

         print sum "$linha";

         last;        
      
      }

   }

close(sum);

my $sh = Shell->new;

$sh->scp("/hosts_walk/resultado/sumario_cpu_mem.txt","root\@10.98.22.11:/fping4.0/snmp/sumario_cpu_mem.txt");

exit

