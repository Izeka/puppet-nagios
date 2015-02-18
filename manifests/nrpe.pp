class nagios::nrpe (
 $nrpe_packages = $nagios::params::nrpe_packages,
 $nrpe_service = $nagios::params::nrpe_service,
 $nrpe_config_file = $nagios::params::nrpe_config_file,

) inherits nagios::params {

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
