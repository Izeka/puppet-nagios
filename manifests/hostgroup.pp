define nagios::hostgroup($name){
    @@nagios_hostgroup { $name:
	hostgroup_name => $name,
	alias => $alias,
	target => "/etc/nagios/conf.d/hostgroups.cfg",
    }
}
