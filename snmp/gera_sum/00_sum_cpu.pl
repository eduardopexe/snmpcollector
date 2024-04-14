#!/usr/local/bin/perl

use Shell;
#gera sumario cpu
my $sh = Shell->new;

$diretorio="/hosts_walk/snmp/cpu/";

opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);

open(sum,">/hosts_walk/snmp/sum/sum_cpu.txt");

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


      foreach $linha (@rttx){

         print sum "$linha";

         last;

      }

}

close(sum);
exit

