define nagios::hostgroup(
$hostgroup_name,
$hostgroup_alias,
$hostgroup_target = $nagios::params::hostgroup_target
)
{
    @@nagios_hostgroup { $hostgroup_name:
	hostgroup_name => $hostgroup_name,
	alias => $hostgroup_alias,
	target => $hostgroup_target,
    }
}
