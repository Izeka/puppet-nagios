define nagios::services::base (
$command,
$description,
$hostgroup_name= false,
$host_name=false,
$nagios_services_file= $nagios::paramas::nagios_services_file
){

@@nagios_service { "$description":
	check_command => $command,
	use => 'generic-service,srv-pnp',
	notification_period => '24x7',
	service_description => $description,
        target => $nagios_services_file,
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



		

