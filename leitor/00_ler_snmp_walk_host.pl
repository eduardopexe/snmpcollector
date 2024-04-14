#!/usr/bin/perl


#/hosts_walk/lista/hosts_snmpwalk.txt
#mcbru01.bru.psys;10.32.37.3;
##### host ip


     %host_interface=();

     open(hint,"/hosts_walk/lista/hosts_snmpwalk.txt");

     @hint=<hint>;

     close(hint);

     $origem_rtt="rtt";

     foreach $lin (@hint){

        $lin=~s/\n//g;
        $lin=~s/\r//g;

        @dd=split(/;/,$lin);
        if (length(@dd[0])<3){

           next;
        }
        @hh=split(/\./,@dd[0]);
        $hostname_full_ip{@dd[0]}=$lin;
        $host_ip{@hh[0]}=$lin;

     }

     #### fim ##### host ip

#/hosts_walk/lista# 

#hashs

#/hosts_walk/lista/host_interface.txt 
#mccta03.cta.psys;Serial4/6:0;snmpa;

##### host interface


     %host_interface=();

     open(hint,"/hosts_walk/lista/host_interface.txt");

     @hint=<hint>;

     close(hint);

     $origem_rtt="rtt";

     foreach $lin (@hint){

        $lin=~s/\n//g;
        $lin=~s/\r//g;

        @dd=split(/;/,$lin);

#        $ref=@dd[0]."_".@dd[1];
        if (length(@dd[0])<3){
#print "@dd[0]\n";
           next;
        }

        $ipl="";
        if (length($hostname_full_ip{@dd[0]})>3){

           $ipl=$hostname_full_ip{@dd[0]};
           $hostn=@dd[0];
        }
        else{

           @hn=split(/\./,@dd[0]);
           @ff=split(/;/,$host_ip{@hn[0]});

           $ipl=@ff[1];
           $hostn=@ff[0];
           if (length($hostn)<3){

              $hostn=@dd[0];
            }
        }

        @dd[1]=~s/controller E1 /E1/g;
        $ref=$hostn."_".@dd[1];
#print "$ref!# \n";
        if (length($host_interface{$ref})>3){

           @di=split(/;/,$host_interface{$ref}); 
           $host_interface{$ref}=$lin.$ipl.";".$di[2];
        }
        else{

           $host_interface{$ref}=$lin.$ipl.";";
        }  
     }

     #### fim ##### host interface

#abrir dir
#/hosts_walk/log
$diretorio="/hosts_walk/log";

opendir (MEUDIR, "$diretorio");

@pegoodir = readdir(MEUDIR);

closedir (MEUDIR);

###arquivo lista com todas interfaces e id
open(id_geral,">/hosts_walk/id_snmp/id_ger.txt");

### arquivo com lista interface id snmp
open(id_getsnmp,">/hosts_walk/id_snmp/id_getsnmp.txt");

### arquivo com lista interface id rtt
open(id_rtt,">/hosts_walk/id_snmp/id_rtt.txt");

### arquivo com erro walk

open(id_err,">/hosts_walk/id_snmp/id_err.txt");

open(id_err_host,">/hosts_walk/id_snmp/id_err_host.txt");

%hint_id=();

   foreach (@pegoodir) {

   $dados = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.


      if ($dados eq '.'){next}

      if ($dados eq '..'){next}

      open (log_fp,"$diretorio/$dados");

      @rtt=<log_fp>;

      close (log_fp);

      $conta=0;

($devicea, $inode, $mode, $nlink, $uid, $gid, $rdev, $size,$atime, $mtime, $ctime, $blksize, $blocks) = stat("$diretorio/$dados");

      foreach $linha (@rtt){

         $linha=~s/\n//g;
         $linha=~s/\r//g;

         if ($linha=~/=/){

            $conta++;
            $linha=~s/STRING: /#/g;

            @d=split(/=/,$linha);
            @id=split(/\./,@d[0]);
            @d[1]=~s/-/#/g;
            @int=split(/#/,@d[1]);

            @id[1]=~s/ //g;
            @int[1]=~s/ //g;

            $host_arq=$dados;

            if ($host_arq=~/-/){

               @hh=split(/-/,$host_arq);
               $host_arq=$hh[0];
            }
            else{

               $host_arq=~s/\.txt//g;

            }

            $refx=$host_arq."_".@int[1];

#            if ($host_arq=~/mcscec01/ and @int[1]=~/1102/){
#print "mcscec01.scec.psys_ATM1/1/0.1102 --- $host_arq _ @int[1]i | $refx = @id[1]\n";
             #  print "@id[1] --- @int[1]  ---- $linha\n";
#            }

#print "$refx#\n";

#para interface serial pega o primeiro id para demais pega o ultimo id

            if ($int[1]=~/Serial|ATM/){

               if (length($hint_id{$refx})<1 and $int[1]=~/Serial/){
                  $hint_id{$refx}=@id[1];
               }
               else{
 
                  if ($lin=~/aal5/ and $int[1]=~/ATM/){
#if ($refx=~/mcscec01/ and $refx=~/1102/){

#print "### $refx -- $id[1]\n";
#}
                     $hint_id{$refx}=@id[1];

                  }
                  else{

                     if($int[1]=~/ATM/){

                        $hint_id{$refx}=@id[1];
                     }

                  }  
               }
            }
            else{

              $hint_id{$refx}=@id[1];

            }

            print id_geral "$host_arq;@int[1];@id[1];$host_interface{$refx}\n";



         }

      }

   if ($conta==0 or $size==0){

      @inf=split(/-/,$dados); 

      $inf[1]=~s/\.txt//g;
      print id_err_host "$inf[0];$inf[1];\n";
      print id_err "$host_arq\n";

   }

   }

#carregar cada arquivo
#ex mccba01.cba.psys.txt

#IF-MIB::ifDescr.1 = STRING: GigabitEthernet0/0

#extrair:::

#idsnmp
#interface

### se for do grupo snmp , grava em lista de get status snmp a e b

### grava lista de interfaces id_snmp

print "#### -- $hint_id{'mcscec01.scec.psys_ATM1/1/0.1102'}; $host_interface{'mcscec01.scec.psys_ATM1/1/0.1102'}\n";
###fim
foreach $item (keys(%host_interface)){

@inf=split(/_/,$item);

@dd=split(/;/,$host_interface{$item});

#if ($dd[2]=~/rtt/){
$dados=$dd[0].";".$dd[1].";".$dd[2].";".$dd[3].";".$dd[4];
#}i

if ($item=~/mcscec01/){
print "$item --- $host_interface{$item} - $hint_id{$item}\n";

}
   if ($hint_id{$item}=~/[0-9]/){

      if ($host_interface{$item}=~/snmp/){
    
         print id_getsnmp "$item;$dados;$hint_id{$item};\n";

      }

      if ($host_interface{$item}=~/rtt/){

         print id_rtt "$item;$dados;$hint_id{$item};\n";

      }

   }
   else {

      print id_err "$item;!$host_interface{$item}!;$hint_id{$item};\n";

      @hx=split(/_/,$item);

      if ($item=~/\./){

         $ip_it=$hostname_full_ip{$hx[0]};
      }
      else{

         $ip_it=$hostname_ip{$hx[0]};

      }

      @inf=split(/;/,$ip_it);
 
print "$ip_it -  $inf[1] \n"; 
      if ($inf[1]=~/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/){

          print id_err_host "$ip_it:\n";
      }
   }

}
###arquivo lista com todas interfaces e id
close(id_geral);

### arquivo com lista interface id snmp
close(id_getsnmp);

### arquivo com lista interface id rtt
close(id_rtt);

### arquivo com erro walk

close(id_err);

close(id_err_host);
exit
