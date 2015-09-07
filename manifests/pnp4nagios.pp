class nagios::pnp4nagios
{
  package {'pnp4nagios':
	ensure => installed,
	allow_virtual => false
	}

  service{'npcd':
	ensure => running,
	enable => true,
	 }

  file {'/usr/share/nagios/html/ssi/status-header.ssi':
	source => 'puppet:///modules/nagios/status-header.ssi',
	owner => 'nagios',
        group => 'nagios',
        mode => '0640',
        require =>  Package['pnp4nagios'],
        notify => Service['nagios'],
	}

  file{'/etc/httpd/conf.d/pnp4nagios.conf':
        source => 'puppet:///modules/nagios/default-pnp4nagios.conf',
        owner => 'nagios',
        group => 'nagios',
        mode => '0644',
 	purge => true,
        require => [ Package['nagios'], Package['pnp4nagios'] ],
	notify => Service['httpd'],
       }

  file{'/usr/local/pnp4nagios/share/install.php':
	ensure => absent,
        require => Package['pnp4nagios'],
       }

  file{'/etc/nagios/conf.d/pnp4nagios.cfg':
                        source => 'puppet:///modules/nagios/pnp4nagios_template.cfg',
                        owner => 'nagios',
                        group => 'nagios',
                        mode => '0640',
			purge => true,
                        require => Package['nagios'],
                        notify => Service['nagios'],
       }
}
