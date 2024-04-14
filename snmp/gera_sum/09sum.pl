#!/usr/local/bin/perl

$diretorio="/hosts_walk/snmp/sum/";

open (log_cpu5,"$diretorio/sum_cpu.txt");

@rttx=<log_cpu5>;

%host_cpu=();

      foreach $linha (@rttx){

         $linha=~s/\n//g;
         $linha=~s/\r//g;

         @dd=split(";",$linha);

         $host_cpu{$dd[2]}=$linha;

      }

#monta hash mem proc

open (log_mem,"$diretorio/sum_mem_proc.txt");

@rttx=<log_mem>;

%host_mem_proc=();

      foreach $linha (@rttx){

         $linha=~s/\n//g;
         $linha=~s/\r//g;

         @dd=split(";",$linha);

         $host_mem_proc{$dd[2]}=$linha;

      }


close(log_cpu5);
close(log_mem);


open(cpumem,">/hosts_walk/resultado/sumario_cpu_mem.txt");

foreach $it (keys(%host_cpu)){

@cput=split(";",$host_cpu{$it});

$t=$cput[0];
$dt=$cput[1];
$cpu5=$cput[3];

   if ($cpu5==0 or $cpu5 eq ""){

      $st_cpu="nao coletou";
   }

   if ($cpu5<31){

      $st_cpu="cpuok";
   }

   if ($cpu5>30){

      $st_cpu="alarmecpu1";
   }
   if ($cpu5>60){

      $st_cpu="alarmecpu2";
   }

   if ($cpu5>90){

      $st_cpu="criticocpu1";
   }

   if ($cpu5>95){

      $st_cpu="criticocpu2";
   }

@memproc=split(";",$host_mem_proc{$it});

$pct_mem=$memproc[6];

print cpumem "$t;$dt;$it;$cpu5;$st_cpu;mem ok;$pct_mem;$pct_mem;\n";

$host_mem_proc{$it}="ok";

}

foreach $itx (keys(%host_mem_proc)){

   if ($host_mem_proc{$itx} eq 'ok'){

      next;

   }
   
@memproc=split(";",$host_mem_proc{$itx});

$pct_mem=$memproc[6];
$st_cpu="nao coletou";
$cpu5="";
$t=$memproc[0];
$dt=$memproc[1];

print cpumem "$t;$dt;$itx;$cpu5;$st_cpu;mem ok;$pct_mem;$pct_mem;\n";

}

close(cpumem);
use Shell;

my $sh = Shell->new;

$sh->scp("/hosts_walk/resultado/sumario_cpu_mem.txt","root\@10.98.22.11:/fping4.0/snmp/sumario_cpu_mem.txt");

exit

