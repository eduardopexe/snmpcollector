#!/bin/bash

perl /hosts_walk/snmp/gera_sum/00_sum_cpu.pl

perl /hosts_walk/snmp/gera_sum/01_sum_mem.pl

perl /hosts_walk/snmp/gera_sum/09sum.pl

exit
