#!/usr/bin/expect -f

log_user 1

set logpath "/hosts_walk/scripts/log"
set user "[lindex $argv 2]"
set pass "[lindex $argv 3]"
set timeout "[lindex $argv 4]"
set data [exec date +%Y%m%d]

set ip "[lindex $argv 1]"
set cpe "[lindex $argv 0]"

set timeout $timeout

spawn telnet "$ip"

log_file "$logpath/$cpe-$ip.txt"

expect "Username:"
send "$user\n"
expect "word:"
send "$pass\n"
expect ">"
send "enable\n"
expect "word:"
send "$pass\n"
expect "#"
send "term len 0\n"
expect "#"
send "conf t\n"
expect "#"
send "no ip access-list standard 91\n"
expect "#"
send "access-list 91 permit 10.98.22.14\n"
expect "#"
send "access-list 91 permit 10.98.22.11\n"
expect "#"
send "access-list 91 deny   any\n"
expect "#"
send "snmp-server community shown0cro RW 91\n"
expect "#"
send "end\n"
expect "#"
send "wr\n"
expect "#"
send "exit\n"

expect "tralia"
log_file

exit

