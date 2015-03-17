# This class exports nagios host and service check resources
class nagios::target(
 $host_name = $nagios::params::host_name,
 $host_address = $nagios::params::host_address,
 $host_use = $nagios::params::host_use,
 $host_group_name = $nagios::params::host_group_name,
 $host_target = $nagios::params::host_target,
){
	 @@nagios_host { $host_name:
		ensure => present,
		alias => $host_name,
		address => $host_address,
		use => $host_use,
		target => $host_target,
	
	 }
	 if ( $host_group_name != 'absent'){
	   Nagios_host[$host_name] { hostgroups => $host_group_name }
	 }

	
}
