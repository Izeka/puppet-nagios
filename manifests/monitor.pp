# Manage the Nagios monitoring service
class nagios::monitor {
include nagios::pnp4nagios

# Manage the packages
	package { [ 'nagios', 'nagios-plugins' ]:
		ensure => present,
		allow_virtual => false
	}
 
# Manage the Nagios monitoring service
	service { 'nagios':
		ensure => running,
		hasstatus => true,
		enable  => true,
		require => Package['nagios'],
	}

# Set nagios.cfg permissions
	file{'/etc/nagios/nagios.cfg':
                        source => 'puppet:///modules/nagios/default-nagios.cfg',
                        owner => 'nagios',
                        group => 'nagios',
                        mode => '0640',
			purge => true,
                        require => [ Package['nagios'],
                        notify => Service['nagios'],
            }	
# Set default commands.cfg
	file{'/etc/nagios/objects/commands.cfg':
                        source => 'puppet:///modules/nagios/default-commands.cfg',
                        owner => 'nagios',
                        group => 'nagios',
                        mode => '0640',
			purge => true,
                        require => [ Package['nagios'], Package['nagios-plugins'] ],
                        notify => Service['nagios'],
            }

#Purge Resources	
        resources {["nagios_host","nagios_service","nagios_hostgroup"]:
	    purge => true,
	    notify => Service["nagios"]
	}

# Make nagios configuration files readeables

	exec{'make_nagios_config_readable':
		command => '/bin/chmod 0644 /etc/nagios/conf.d/*.cfg',
		require => [ Package['nagios'], Package['nagios-plugins'] ],
		notify => Service['nagios']
	}
# Remove old configurations
	exec { "remove_nagios_config":
	   command => '/bin/rm -f  /etc/nagios/conf.d/*',
	}

        Nagios_host <<||>> { require => Exec['remove_nagios_config'], notify  => Exec['make_nagios_config_readable'] }
        Nagios_hostgroup <<||>> { require => Exec['remove_nagios_config'],notify  => Exec['make_nagios_config_readable']}
        Nagios_service <<||>> { require => Exec['remove_nagios_config'], notify  => Exec['make_nagios_config_readable'] }
}
