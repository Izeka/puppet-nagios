define nagios::services::base (
$command,
$description,
$hostgroup_name= false,
$host_name=false,
){

@@nagios_service { "$description":
	check_command => $command,
	use => 'generic-service,srv-pnp',
	notification_period => '24x7',
	service_description => $description,
        target => "/etc/nagios/conf.d/services.cfg",
        max_check_attempts => 3,
	hostgroup_name => $hostgroup_name ? {
   	  false => undef,
	  '' => '',
	  default => $hostgroup_name
	},
	host_name => $host_name ? {
	  false => undef,
	  default => $host_name,
	}
      }
}



		

