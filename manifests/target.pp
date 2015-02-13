# This class exports nagios host and service check resources
class nagios::target
{
	@@nagios_host { $::hostname:
		ensure => present,
		alias => $::hostname,
		address => $::ipaddress,
		use => 'linux-server,host-pnp',
		hostgroups => 'linux-servers',
		target => '/etc/nagios/conf.d/linux_servers.cfg',
	}
}
