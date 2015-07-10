class nagios::params{

	#host parameters
	$host_name = $::hostname
	$host_address = $::ipaddress
	$host_use = 'linux-server,host-pnp'
	$host_group_name = 'linux-servers'

	#hostgroup parameters
        $hostgroup_target ="/etc/nagios/conf.d/hostgroups.cfg"

	#nagios monitor parameters
	$nagios_packages = ["nagios"]
	$nagios_service = "nagios"
	$nagios_config_file = "/etc/nagios/nagios.cfg"
	$nagios_commands_file = "/etc/nagios/objects/commands.cfg"
        $nagios_config_folder = "/etc/nagios/conf.d"
	$host_target =  '/etc/nagios/conf.d/linux_servers.cfg'

case $::operatingsystem {

    "RedHat", "CentOS": {

	#nrpe parameters
	$nrpe_server_address = hiera('nrpe_server_address')
 	$nrpe_packages = ["nrpe","nagios-plugins-nrpe","nagios-plugins-all"]
	$nrpe_service = "nrpe"
        $nrpe_config_file = "/etc/nagios/nrpe.cfg"
        $nrpe_config_template = "nagios/centos-nrpe_config.erb"
    }
    "ubuntu","debian":{

	#nrpe parameters
	$nrpe_packages = ["nagios-nrpe-plugin","nagios-nrpe-server","nagios-plugins"]
	$nrpe_service = "nagios-nrpe-server"
	$nrpe_server_address = hiera('nrpe_server_address')
        $nrpe_config_file = "/etc/nagios/nrpe.cfg"
	$nrpe_config_template = "nagios/debian-nrpe_config.erb"
	}
    default: {
         fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
      }
    }
}
 
