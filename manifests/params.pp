# == Class: zabbix
#
# Parameters userd for for zabbix agent, proxy and server configuration
#
# === Variables
#
# Most of them are named very similiar to variables configuration files.
# Should be obvious enough :)
#
class zabbix::params {
  ### commmon parameter
  $zabbix_server             = undef
  $hostname                  = $::hostname
  $hostname_item             = 'system.hostname'
  $source_ip                 = undef
  $log_file_size             = 1
  $debug_level               = 3
  $timeout                   = 3
  $allow_root                = 0
  ## server/proxy common parametrs
  $listen_port               = 10051
  $db_host                   = 'localhost'
  $db_name                   = 'zabbix'
  $db_schema                 = undef
  $db_user                   = 'zabbix'
  $db_password               = undef
  $db_port                   = 3306
  $start_pollers             = 5
  $start_ipmi_pollers        = 0
  $start_pollers_unreachable = 1
  $start_trappers            = 5
  $start_pingers             = 1
  $start_discoverers         = 1
  $start_http_pollers        = 1
  $java_gateway              = undef
  $java_gateway_port         = 10052
  $start_java_pollers        = 0
  $start_vmware_collectors   = 0
  $vmware_frequency          = 60
  $vmware_cache_size         = '8M'
  $snmp_trapper_file         = '/var/log/snmptt/snmptt.log'
  $start_snmp_trapper        = 0
  $listen_ip                 = '0.0.0.0'
  $housekeeping_frequency    = 1
  $cache_size                = '8M'
  $start_db_syncers          = 4
  $history_cache_size        = '8M'
  $history_text_cache_size   = '16M'
  $trapper_timeout           = 300
  $unreachable_period        = 45
  $unavailable_delay         = 60
  $unreachable_delay         = 15
  $external_scripts          = '${datadir}/zabbix/externalscripts'
  #$external_scripts          = '/usr/lib/zabbix/externalscripts'
  $fping_location            = '/usr/sbin/fping'
  $fping6_location           = '/usr/sbin/fping6'
  $ssh_key_location          = undef
  $log_slow_queries          = 0
  $tmp_dir                   = '/tmp'
  $load_module_path          = '${libdir}/modules' # new!
  $load_module               = undef
  ### agent specific parameters
  $agent_package_name        = 'zabbix-agent'
  $agent_service_name        = 'zabbix-agent'
  $agent_config_template     = 'zabbix/zabbix_agentd.conf.erb'
  $agent_pid_file            = '/var/run/zabbix/zabbix_agentd.pid'
  $agent_log_file            = '/var/log/zabbix/zabbix_agentd.log'
  $agent_config_file         = '/etc/zabbix/zabbix_agentd.conf'
  $enable_remote_commands    = 0
  $log_remote_commands       = 0
  $agent_listen_port         = 10050
  $start_agents              = 3
  $zabbix_server_active      = undef
  $host_metadata             = undef
  $host_metadata_item        = undef
  $refresh_active_checks     = 120
  $buffer_send               = 5
  $buffer_size               = 100
  $max_lines_per_second      = 100
  $agent_alias               = undef
  $agent_include             = '/etc/zabbix/zabbix_agentd.d/'
  $unsafe_user_parameters    = 0
  $user_parameter            = undef
  ### proxy specific parameters
  $proxy_package_name        = 'zabbix-proxy'
  $proxy_service_name        = 'zabbix-proxy'
  $proxy_config_template     = 'zabbix/zabbix_proxy.conf.erb'
  $proxy_config_file         = '/etc/zabbix/zabbix_proxy.conf'
  $proxy_mode                = 0
  $proxy_log_file            = '/var/log/zabbix/zabbix_proxy.log'
  $proxy_pid_file            = '/var/run/zabbix/zabbix_proxy.pid'
  $proxy_db_host             = 'localhost'
  $proxy_db_name             = 'zabbix'
  $proxy_db_name_sqlite3     = '/var/lib/zabbix/zabbix.db'# TODO check for mysql and pgsql
  $proxy_local_buffer        = 0
  $proxy_offline_buffer      = 1
  $heartbeat_frequency       = 60
  $config_frequency          = 3600
  $proxy_include             = '/etc/zabbix/zabbix_proxy.d/'
  ### server specific parameters
  $server_package_name       = 'zabbix-server'
  $server_service_name       = 'zabbix-server'
  $server_config_template    = 'zabbix/zabbix_server.conf.erb'
  $server_config_file        = '/etc/zabbix/zabbix_server.conf'
  $node_id                   = 0
  $server_log_file           = '/var/log/zabbix/zabbix_server.log'
  $server_pid_file           = '/var/run/zabbix/zabbix_server.pid'
  $start_timers              = 1
  $max_housekeeper_delete    = 500
  $sender_frequency          = 30
  $cache_update_frequency    = 60
  $trend_cache_size          = '4M'
  $value_cache_size          = '8M'
  $node_no_events            = 0
  $node_no_history           = 0
  $alert_scripts_path        = '${datadir}/zabbix/alertscripts'
  #$alert_scripts_path        = '/usr/lib/zabbix/alertscripts'
  $start_proxy_pollers       = 1
  $proxy_config_frequency    = 3600
  $proxy_data_frequency      = 1
  $server_include            = '/etc/zabbix/zabbix_server.d/'


  case $::operatingsystem {

    /(Ubuntu|Debian)/: {
      $db_socket = '/var/run/mysqld/mysqld.sock'
    }
    /(RedHat|CentOS|Fedora|SLC)/: {
      $db_socket = '/var/lib/mysql/mysql.sock'
    }
    default: {
      fail("${::operatingsystem} is not supported yet!")
    }

  }

}
