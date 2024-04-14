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


$diretorio="/coleta_rttm/log_coleta5";

opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);


$t=time();

   foreach (@pegoodir) {


      $dados = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.


      if ($dados eq '.'){next}

      if ($dados eq '..'){next}

      open (log_rtt5,"$diretorio/$dados");

      @rtt=<log_rtt5>;

      close (log_rtt5);

##################################

%interface=();

%if_in=();

%if_out=();

%if_in_errs=();

%if_out_errs=();

$cpu5="";

$mem_util="";

$mem_free="";

@d=split(/-/,$dados);

$ip=@d[0];

$host=@d[1];

$host=~s/\.txt//g;
#################################
      foreach $linha (@rtt){

         $linha=~s/\n//g;
         $linha=~s/\r//g;
         $linha=~s/\"//g;

         #ifDescr

#         if ($linha=~/\.9\.9\.16\.1\.1\.1\.9\./){

         if ($linha=~/ifDescr\./){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            @ins=split(/=/,$linha);

            @int=split(/\./,@ins[0]);

            $sent=~s/ //g;

            @int[1]=~s/ //g;

            $interface{@int[1]}=$sent;

         }

         #ifInOctets

         if ($linha=~/ifInOctets\./){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            @ins=split(/=/,$linha);

            @int=split(/\./,@ins[0]);

            $sent=~s/ //g;

            @int[1]=~s/ //g;

#print "@int[1] #- $sent ######3\n";
            $if_in{@int[1]}=$sent;

         }

         #ifOutOctets

         if ($linha=~/ifOutOctets\./){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            @ins=split(/=/,$linha);

            @int=split(/\./,@ins[0]);

            $sent=~s/ //g;

            @int[1]=~s/ //g;

            $if_out{@int[1]}=$sent;

         }

         #ifInErrors

         if ($linha=~/ifInErrors\./){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            @ins=split(/=/,$linha);

            @int=split(/\./,@ins[0]);

            $sent=~s/ //g;

            @int[1]=~s/ //g;

            $if_in_errs{@int[1]}=$sent;

         }

         #ifOutErrors

         if ($linha=~/ifOutErrors\./){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            @ins=split(/=/,$linha);

            @int=split(/\./,@ins[0]);

            $sent=~s/ //g;

            @int[1]=~s/ //g;

            $if_out_errs{@int[1]}=$sent;

         }

         #cpu 5 min

         if ($linha=~/enterprises\.9\.2\.1\.58\.0/){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            $cpu5=$sent;
            $cpu5=~s/ //g;
         }

         #mem utilizada

         if ($linha=~/enterprises\.9\.9\.48\.1\.1\.1\.5\.1/){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            $mem_util=$sent;
            $mem_util=~s/ //g;
         }

         #mem free

         if ($linha=~/enterprises\.9\.9\.48\.1\.1\.1\.6\.1/){

            @sent=split(/:/,$linha);

            $sent=@sent[3];

            $mem_free=$sent;
            $mem_free=~s/ //g;
         }



      }


         foreach $item (keys(%if_in)){ 

            print "$t;$host;$ip;$interface{$item};$if_in{$item};$if_out{$item};$if_in_errs{$item};$if_out_errs{$item};$cpu5;$mem_util;$mem_free;\n"; 

         }

   }

