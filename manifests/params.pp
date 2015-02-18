class nagios::params{
case $::operatingsystem {
    'RedHat', 'CentOS': {
	$nagios_packages = ["nagios","nagios-plugins-all"]
	$nagios_service = "nagios"
	$nagios_config_file = "/etc/nagios/nagios.cfg"
	$nagios_commands_file = "/etc/nagios/objects/commands.cfg"
        $nagios_config_folder = "/etc/nagios/conf.d"

 	$nrpe_packages = ["nrpe","nagios-plugins-nrpe","nagios-plugins-all"] 
	$nrpe_service = 'nrpe'
        $nrpe_config_file = 'puppet:///modules/nagios/centos-nrpe.cfg'
    }
    'ubuntu','debian':{
	$nrpe_packages = ["nagios-plugins","nagios-nrpe-plugin","nagios-nrpe-server"]
	$nrpe_service = 'nagios-nrpe-server'
	$nrpe_config_file = 'puppet:///modules/nagios/debian-nrpe.cfg'
	}
    default: {
         fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
      }
    }
}
 
