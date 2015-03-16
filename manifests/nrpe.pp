class nagios::nrpe (
 $nrpe_packages = $nagios::params::nrpe_packages,
 $nrpe_service = $nagios::params::nrpe_service,
 $nrpe_config_file = $nagios::params::nrpe_config_file,
 $nrpe_config_template = $nagios::params::nrpe_config_template,
 $nrpe_server_address = $nagios::params::nrpe_server_address,
) inherits nagios::params {

package {$nrpe_packages:
         ensure => present,
         allow_virtual => false
        }

service {$nrpe_service:
    	 ensure => running,
	 require => Package[$nrpe_packages]
	}

file {'nrpe configuration file':
      path => $nrpe_config_file,
      content => template($nrpe_config_template),
      require => Package[$nrpe_packages],
      notify => Service[$nrpe_service],	
     }

}
