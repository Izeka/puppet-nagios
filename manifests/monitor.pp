# Manage the Nagios monitoring service
class nagios::monitor(
 $nagios_packages = $nagios::params::nagios_packages, 
 $nagios_service = $nagios::params::nagios_service,
 $nagios_config_file = $nagios::params::nagios_config_file,
 $nagios_config_folder = $nagios::params::nagios_config_folder,
) inherits nagios::params {

# Manage the packages
	package { $nagios_packages:
		ensure => present,
		allow_virtual => false
	}
 
# Manage the Nagios monitoring service
	service { $nagios_service:
		ensure => running,
		hasstatus => true,
		enable  => true,
		require => Package[$nagios_packages],
	}

# Set nagios.cfg permissions
	file{$nagios_config_file:
                        source => 'puppet:///modules/nagios/default-nagios.cfg',
                        owner => 'nagios',
                        group => 'nagios',
                        mode => '0640',
			purge => true,
                        require => Package[$nagios_packages],
                        notify => Service[$nagios_service],
            }	
# Set default commands.cfg
	file{$nagios_commands_file:
                        source => 'puppet:///modules/nagios/default-commands.cfg',
                        owner => 'nagios',
                        group => 'nagios',
                        mode => '0640',
			purge => true,
 		        require => Package[$nagios_packages],
                        notify => Service[$nagios_service],
            }

#Purge Resources	
        resources {["nagios_host","nagios_service","nagios_hostgroup"]:
	    purge => true,
	    notify => Service[$nagios_service]
	}

# Make nagios configuration files readeables

	exec{'make_nagios_config_readable':
		command => "/bin/chmod 0644 $nagios_config_folder/*.cfg",
		require => Package[$nagios_packages],
		notify => Service[$nagios_service]
	}
# Remove old configurations
	exec { "remove_nagios_config":
	   command => "/bin/rm -f  $nagios_config_folder/*",
	}

        Nagios_host <<||>> { require => Exec['remove_nagios_config'], notify  => Exec['make_nagios_config_readable'] }
        Nagios_hostgroup <<||>> { require => Exec['remove_nagios_config'],notify  => Exec['make_nagios_config_readable']}
        Nagios_service <<||>> { require => Exec['remove_nagios_config'], notify  => Exec['make_nagios_config_readable'] }
}
