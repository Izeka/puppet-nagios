class nagios::nrpe{

case $::operatingsystem {
    'RedHat', 'CentOS': {
 	$nrpe_packages=["nrpe","nagios-plugins-nrpe","nagios-plugins-all"] 
	$nrpe_service='nrpe'
        $nrpe_config_file='puppet:///modules/nagios/centos6-nrpe.cfg'
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

service {$nrpe_service:
    	 ensure => running,
	 require => Package[$nrpe_packages]
	}

file {'/etc/nagios/nrpe.cfg':
      source => $nrpe_config_file,
      require => Package[$nrpe_packages],
      notify => Service[$nrpe_service],	
     }
}
