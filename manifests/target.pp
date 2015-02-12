# This class exports nagios host and service check resources
class nagios::target {
   case $::operatingsystem {
    'RedHat', 'CentOS': {
	if versioncmp($operatingsystemrelease, '7.0') < 0 {
         $nrpe_config_file='puppet:///modules/nagios/centos6-nrpe.cfg'
	}
        else{
         $nrpe_config_file='puppet:///modules/nagios/centos7-nrpe.cfg'
	}
 	$nrpe_packages=["nrpe","nagios-plugins-nrpe","nagios-plugins-all"] 
	$nrpe_service='nrpe'
    }
    'ubuntu','debian':{
	$nrpe_packages=["nagios-plugins","nagios-nrpe-plugin","nagios-nrpe-server"]
	$nrpe_service='nagios-nrpe-server'
	$nrpe_config_file='puppet:///modules/nagios/debian-nrpe.cfg'
	}
    }
        package {$nrpe_packages:
                ensure => present,
                allow_virtual => false
                }

	service{$nrpe_service:
	 	ensure => running,
	}
	file{'/etc/nagios/nrpe.cfg':
                source => $nrpe_config_file,
		require => Package[$nrpe_packages],
                notify => Service[$nrpe_service],
 	}

	@@nagios_host { $::hostname:
		ensure => present,
		alias => $::hostname,
		address => $::ipaddress,
		use => 'linux-server,host-pnp',
		hostgroups => 'linux-servers',
		target => "/etc/nagios/conf.d/linux_servers.cfg"
	}
}
