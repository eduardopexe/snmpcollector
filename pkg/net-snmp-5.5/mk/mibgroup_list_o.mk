# contents below built automatically by configure; do not edit by hand
mibgroup_list_o= \
	mibgroup/snmpv3/snmpMPDStats_5_5.o \
	mibgroup/snmpv3/usmStats_5_5.o \
	mibgroup/snmpv3/snmpEngine.o \
	mibgroup/snmpv3/usmUser.o \
	mibgroup/mibII/snmp_mib_5_5.o \
	mibgroup/mibII/system_mib.o \
	mibgroup/mibII/sysORTable.o \
	mibgroup/mibII/at.o \
	mibgroup/mibII/ip.o \
	mibgroup/mibII/tcp.o \
	mibgroup/mibII/icmp.o \
	mibgroup/mibII/udp.o \
	mibgroup/mibII/vacm_vars.o \
	mibgroup/mibII/setSerialNo.o \
	mibgroup/mibII/ipv6.o \
	mibgroup/ucd-snmp/proc.o \
	mibgroup/ucd-snmp/versioninfo.o \
	mibgroup/ucd-snmp/pass.o \
	mibgroup/ucd-snmp/pass_persist.o \
	mibgroup/ucd-snmp/disk.o \
	mibgroup/ucd-snmp/loadave.o \
	mibgroup/agent/extend.o \
	mibgroup/ucd-snmp/errormib.o \
	mibgroup/ucd-snmp/file.o \
	mibgroup/ucd-snmp/dlmod.o \
	mibgroup/ucd-snmp/proxy.o \
	mibgroup/ucd-snmp/logmatch.o \
	mibgroup/ucd-snmp/memory.o \
	mibgroup/ucd-snmp/vmstat.o \
	mibgroup/notification/snmpNotifyTable.o \
	mibgroup/notification/snmpNotifyFilterProfileTable.o \
	mibgroup/notification-log-mib/notification_log.o \
	mibgroup/target/target_counters_5_5.o \
	mibgroup/target/snmpTargetAddrEntry.o \
	mibgroup/target/snmpTargetParamsEntry.o \
	mibgroup/target/target.o \
	mibgroup/agent/nsTransactionTable.o \
	mibgroup/agent/nsModuleTable.o \
	mibgroup/agent/nsDebug.o \
	mibgroup/agent/nsCache.o \
	mibgroup/agent/nsLogging.o \
	mibgroup/agent/nsVacmAccessTable.o \
	mibgroup/disman/event/mteScalars.o \
	mibgroup/disman/event/mteTrigger.o \
	mibgroup/disman/event/mteTriggerTable.o \
	mibgroup/disman/event/mteTriggerDeltaTable.o \
	mibgroup/disman/event/mteTriggerExistenceTable.o \
	mibgroup/disman/event/mteTriggerBooleanTable.o \
	mibgroup/disman/event/mteTriggerThresholdTable.o \
	mibgroup/disman/event/mteTriggerConf.o \
	mibgroup/disman/event/mteEvent.o \
	mibgroup/disman/event/mteEventTable.o \
	mibgroup/disman/event/mteEventSetTable.o \
	mibgroup/disman/event/mteEventNotificationTable.o \
	mibgroup/disman/event/mteEventConf.o \
	mibgroup/disman/event/mteObjects.o \
	mibgroup/disman/event/mteObjectsTable.o \
	mibgroup/disman/event/mteObjectsConf.o \
	mibgroup/disman/schedule/schedCore.o \
	mibgroup/disman/schedule/schedConf.o \
	mibgroup/disman/schedule/schedTable.o \
	mibgroup/utilities/override.o \
	mibgroup/host/hr_swinst.o \
	mibgroup/host/hr_swrun.o \
	mibgroup/host/hr_system.o \
	mibgroup/host/hr_storage.o \
	mibgroup/host/hr_device.o \
	mibgroup/host/hr_other.o \
	mibgroup/host/hr_proc.o \
	mibgroup/host/hr_network.o \
	mibgroup/host/hr_print.o \
	mibgroup/host/hr_disk.o \
	mibgroup/host/hr_partition.o \
	mibgroup/host/hr_filesys.o \
	mibgroup/utilities/snmp_get_statistic.o \
	mibgroup/util_funcs/header_generic.o \
	mibgroup/mibII/updates.o \
	mibgroup/util_funcs.o \
	mibgroup/mibII/kernel_linux.o \
	mibgroup/mibII/ipAddr.o \
	mibgroup/mibII/var_route.o \
	mibgroup/mibII/route_write.o \
	mibgroup/mibII/tcpTable.o \
	mibgroup/mibII/udpTable.o \
	mibgroup/mibII/vacm_context.o \
	mibgroup/ip-mib/ip_scalars.o \
	mibgroup/util_funcs/header_simple_table.o \
	mibgroup/header_complex.o \
	mibgroup/snmp-notification-mib/snmpNotifyFilterTable/snmpNotifyFilterTable.o \
	mibgroup/if-mib/ifTable/ifTable.o \
	mibgroup/if-mib/ifXTable/ifXTable.o \
	mibgroup/ip-mib/ipAddressTable/ipAddressTable.o \
	mibgroup/ip-mib/inetNetToMediaTable/inetNetToMediaTable.o \
	mibgroup/ip-mib/inetNetToMediaTable/inetNetToMediaTable_interface.o \
	mibgroup/ip-mib/inetNetToMediaTable/inetNetToMediaTable_data_access.o \
	mibgroup/ip-mib/ipSystemStatsTable/ipSystemStatsTable.o \
	mibgroup/ip-mib/ipSystemStatsTable/ipSystemStatsTable_interface.o \
	mibgroup/ip-mib/ipSystemStatsTable/ipSystemStatsTable_data_access.o \
	mibgroup/ip-mib/ipv6ScopeZoneIndexTable/ipv6ScopeZoneIndexTable.o \
	mibgroup/ip-mib/ipIfStatsTable/ipIfStatsTable.o \
	mibgroup/ip-mib/ipIfStatsTable/ipIfStatsTable_interface.o \
	mibgroup/ip-mib/ipIfStatsTable/ipIfStatsTable_data_access.o \
	mibgroup/ip-forward-mib/ipCidrRouteTable/ipCidrRouteTable.o \
	mibgroup/ip-forward-mib/inetCidrRouteTable/inetCidrRouteTable.o \
	mibgroup/tcp-mib/tcpConnectionTable/tcpConnectionTable.o \
	mibgroup/tcp-mib/tcpListenerTable/tcpListenerTable.o \
	mibgroup/udp-mib/udpEndpointTable/udpEndpointTable.o \
	mibgroup/hardware/memory/hw_mem.o \
	mibgroup/hardware/memory/memory_linux.o \
	mibgroup/hardware/cpu/cpu.o \
	mibgroup/hardware/cpu/cpu_linux.o \
	mibgroup/snmp-notification-mib/snmpNotifyFilterTable/snmpNotifyFilterTable_interface.o \
	mibgroup/snmp-notification-mib/snmpNotifyFilterTable/snmpNotifyFilterTable_data_access.o \
	mibgroup/if-mib/data_access/interface.o \
	mibgroup/if-mib/ifTable/ifTable_interface.o \
	mibgroup/if-mib/ifTable/ifTable_data_access.o \
	mibgroup/if-mib/ifXTable/ifXTable_interface.o \
	mibgroup/if-mib/ifXTable/ifXTable_data_access.o \
	mibgroup/ip-mib/ipAddressTable/ipAddressTable_interface.o \
	mibgroup/ip-mib/ipAddressTable/ipAddressTable_data_access.o \
	mibgroup/ip-mib/data_access/arp_common.o \
	mibgroup/ip-mib/data_access/arp_linux.o \
	mibgroup/ip-mib/data_access/systemstats_common.o \
	mibgroup/ip-mib/data_access/systemstats_linux.o \
	mibgroup/ip-mib/data_access/scalars_linux.o \
	mibgroup/ip-mib/ipv6ScopeZoneIndexTable/ipv6ScopeZoneIndexTable_interface.o \
	mibgroup/ip-mib/ipv6ScopeZoneIndexTable/ipv6ScopeZoneIndexTable_data_access.o \
	mibgroup/ip-mib/ipIfStatsTable/ipIfStatsTable_data_get.o \
	mibgroup/ip-forward-mib/ipCidrRouteTable/ipCidrRouteTable_interface.o \
	mibgroup/ip-forward-mib/ipCidrRouteTable/ipCidrRouteTable_data_access.o \
	mibgroup/ip-forward-mib/inetCidrRouteTable/inetCidrRouteTable_interface.o \
	mibgroup/ip-forward-mib/inetCidrRouteTable/inetCidrRouteTable_data_access.o \
	mibgroup/tcp-mib/data_access/tcpConn_common.o \
	mibgroup/tcp-mib/data_access/tcpConn_linux.o \
	mibgroup/util_funcs/get_pid_from_inode.o \
	mibgroup/tcp-mib/tcpConnectionTable/tcpConnectionTable_interface.o \
	mibgroup/tcp-mib/tcpConnectionTable/tcpConnectionTable_data_access.o \
	mibgroup/tcp-mib/tcpListenerTable/tcpListenerTable_interface.o \
	mibgroup/tcp-mib/tcpListenerTable/tcpListenerTable_data_access.o \
	mibgroup/udp-mib/udpEndpointTable/udpEndpointTable_interface.o \
	mibgroup/udp-mib/udpEndpointTable/udpEndpointTable_data_access.o \
	mibgroup/if-mib/data_access/interface_linux.o \
	mibgroup/if-mib/data_access/interface_ioctl.o \
	mibgroup/ip-mib/data_access/ipaddress_common.o \
	mibgroup/ip-mib/data_access/ipaddress_linux.o \
	mibgroup/ip-mib/data_access/ipv6scopezone_common.o \
	mibgroup/ip-mib/data_access/ipv6scopezone_linux.o \
	mibgroup/ip-forward-mib/data_access/route_common.o \
	mibgroup/ip-forward-mib/data_access/route_linux.o \
	mibgroup/ip-forward-mib/data_access/route_ioctl.o \
	mibgroup/udp-mib/data_access/udp_endpoint_common.o \
	mibgroup/udp-mib/data_access/udp_endpoint_linux.o \
	mibgroup/ip-mib/data_access/ipaddress_ioctl.o

# end configure generated code
