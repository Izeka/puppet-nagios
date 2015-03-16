class nagios::services::linuxservers {  

 nagios::hostgroup{'linux':
	hostgroup_name =>'linux-servers',
	hostgroup_alias => 'Linux Servers' 
 }

 nagios::services::base {'PING':
                                description => 'PING',
                                command => 'check_ping!100.0,20%!500.0,60%',
                                hostgroup_name => 'linux-servers',
                                host_name => false
                        }
 nagios::services::base {'Current Users':
                                description => 'Current Users',
                                command => 'check_nrpe!check_users',
                                hostgroup_name => 'linux-servers',
                                host_name => false
                        }
 nagios::services::base {'Total Processes':
                                description => 'Total Processes',
                                command => 'check_nrpe!check_total_procs',
                                hostgroup_name => 'linux-servers',
                                host_name => false
                        }
 nagios::services::base {'Current Load':
                                description => 'Current Load',
                                command => 'check_nrpe!check_load!5.0,4.0,3.0!10.0,6.0,4.0',
                                hostgroup_name => 'linux-servers',
                                host_name => false
                        }
 nagios::services::base {'SSH':
                                description => 'SSH',
                                command => 'check_ssh',
                                hostgroup_name => 'linux-servers',
                                host_name => false
                        }
}




