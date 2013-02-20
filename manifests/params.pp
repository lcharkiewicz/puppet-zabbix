# == Class: zabbix
#
# Parameters userd for for zabbix agent and server configuration
#
# === Variables
#
# Most of them are named very similiar to variables configuration files.
# Should be obvious enough :)
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class zabbix::params {
  # agent parameters
  $agent_server                     = undef
  $agent_server_active              = undef
  $agent_debug_level                = 3
  $agent_source_ip                  = undef
  $agent_enable_remote_commands     = 0
  $agent_log_remote_commands        = 0
  $agent_hostname                   = $::hostname # passive checks
  $agent_hostname_item              = 'system.hostname'
  $agent_listen_port                = 10050
  $agent_listen_ip                  = '0.0.0.0'
  $agent_refresh_active_checks      = 120 # active checks
  $agent_buffer_send                = 5
  $agent_buffer_size                = 100
  $agent_max_lines_per_second       = 100
  $agent_allow_root                 = 0
  $agent_alias                      = undef # advanced params
  $agent_start_agents               = 3
  $agent_timeout                    = 3
  $agent_unsafe_user_parameters     = 0 # user defined monitored parameters
  $agent_user_parameter             = undef

  # server parameters
  $server_node_id                   = 0
  $server_listen_ip                 = 10051
  $server_source_ip                 = undef
  $server_debug_level               = 3
  $server_db_host                   = 'localhost'
  $server_db_name                   = 'zabbix' # for non-sqlite
  $server_db_user                   = 'zabbix'
  $server_db_password               = undef
  $server_db_port                   = # 3306 for mysql,
  $server_start_pollers             = 5
  $server_start_ipmi_pollers        = 0
  $server_start_pollers_unreachable = 1
  $server_start_trappers            = 5
  $server_start_pingers             = 1
  $server_start_discovers           = 1
  $server_start_http_pollers        = 1
  $server_listen_ip                 = '0.0.0.0'
  $server_housekeeping_frequency    = 1
  $server_max_housekeeper_delete    = 500
  $server_disable_housekeeping      = 0
  $server_sender_frequency          = 30
  $server_cache_size                = '8M'
  $server_cache_update_frequency    = 60
  $server_start_db_syncers          = 4
  $server_history_cache_size        = '8M'
  $server_trend_cache_size          = '8M'
  $server_history_text_cache_size   = '16M'
  $server_node_no_events            = 0
  $server_node_no_history           = 0
  $server_timeout                   = 3
  $server_traper_timeout            = 300
  $server_unreachable_period        = 45
  $server_unavailable_delay         = 60
  $server_unreachable_delay         = 15
  $server_fping_location            = '/usr/sbin/fping'
  $server_fping6_location           = '/usr/sbin/fping6'
  $server_ssh_key_location          = undef
  $server_log_slow_queries          = 0
  $server_tmp_dir                   = '/tmp'
  $server_include                   = undef
  $server_start_proxy_pollers       = 1
  $server_proxy_config_frequency    = 3600
  $server_proxy_data_frequency      = 1

  # proxy parameters
  $proxy_proxy_mode                 = 0
  $proxy_server                     = undef
  $proxy_server_port                = 10051
  $proxy_hostname                   = $::hostname
  $proxy_hostname_item              = 'system.hostname'
  $proxy_listen_port                = 10051
  $proxy_source_ip                  = undef
  $proxy_debug_level                = 3
  $proxy_db_host                    = 'localhost'
  $proxy_db_name                    = 'zabbix'
  $proxy_db_user                    = 'zabbix'
  $proxy_db_password                = undef
  $proxy_db_port                    = # 3306 for mysql, for pgsql
  $proxy_proxy_local_buffer         = 0
  $proxy_proxy_offline_buffer       = 1
  $proxy_heartbeat_frequency        = 60
  $proxy_config_frequency           = 3600
  $proxy_data_sender_frequency      = 1
  $proxy_start_pollers              = 5
  $proxy_start_ipmi_pollers         = 0
  $proxy_start_pollers_unreachable  = 1
  $proxy_start_trappers             = 5
  $proxy_start_pingers              = 1
  $proxy_start_discovers            = 1
  $proxy_listen_ip                  = '0.0.0.0'
  $proxy_housekeeping_frequency     = 1
  $proxy_cache_size                 = '8M'
  $proxy_start_db_syncers           = 4
  $proxy_history_cache_size         = '8M'
  $proxy_history_text_cache_size    = '16M'
  $proxy_timeout                    = 3
  $proxy_trapper_timeout            = 300
  $server_unreachable_period        = 45
  $server_unavailable_delay         = 60
  $server_unreachable_delay         = 15
  $server_fping_location            = '/usr/sbin/fping'
  $server_fping6_location           = '/usr/sbin/fping6'
  $server_ssh_key_location          = undef
  $server_log_slow_queries          = 0
  $server_tmp_dir                   = '/tmp'
  $server_include                   = undef

  case $::operatingsystem {
    default, /(Ubuntu|Debian)/: {
      $agent_package_name            = 'zabbix-agent'
      $agent_service_name            = 'zabbix-agentd'
      $agent_config_file             = '/etc/zabbix/zabbix-agent.conf'
      $agentd_config_file            = '/etc/zabbix/zabbix-agentd.conf'
      $agentd_config_template        = 'zabbix/ubuntu.zabbix_agentd.conf.erb'
      $server_package_name           = 'zabbix-server'# TODO - zabbix-server-{sqlite3,mysql,pgsql}
      $server_service_name           = 'zabbix-server'
      $agentd_pid_file               = '/var/run/zabbix/zabbix_agentd.pid'
      $agentd_log_file               = '/var/log/zabbix/zabbix_agentd.log'
      $agentd_log_file_size          = 0
      $agent_disable_passive         = 0
      $agent_disable_active          = 0
      $agent_server_port             = 10051
      $agent_include                 = '/etc/zabbix/zabbix_agentd.conf.d/'
      $server_pid_file               = '/var/run/zabbix/zabbix_server.pid'
      $server_log_file               = '/var/log/zabbix-server/zabbix_server.log'
      $server_log_file_size          = 1
      $server_db_socket              = '/tmp/mysql.sock'
      $server_alert_scripts_path     = '/etc/zabbix/alert.d/'
      $proxy_pid_file                = '/var/run/zabbix/zabbix_proxy.pid'
      $proxy_log_file                = '/var/log/zabbix-proxy/zabbix_proxy.log'
      $proxy_log_file_size           = 1
      $proxy_db_name_sqlite3         = '/var/lib/zabbix/zabbix.db'# TODO check for mysql and pgsql
      $proxy_db_socket               = '/tmp/mysql.sock'
      #$proxy_cache_update_frequency = 60
      #$proxy_trend_size_cache       = '4M'
    }

    /(RedHat|CentOS|Fedora)/: {
      case $zabbix::agent::is_20_version {
        true: {
          $agent_package_name        = 'zabbix20-agent'
          # TODO - zabbix-server-{sqlite3,mysql,pgsql}
          $server_package_name       = 'zabbix20-server'
          # TODO - zabbix-proxy-{sqlite3,mysql,pgsql}
          $proxy_package_name        = 'zabbix20-proxy'
          $web_package_name          = 'zabbix20-web'
          $server_pid_file           = '/var/run/zabbix/zabbix_server.pid'
          $server_java_gateway       = undef
          $server_java_gateway_port  = 10052
          $server_start_java_pollers = 0
          $server_smtp_trapper_file  = '/tmp/zabbix_traps.tmp'
          $server_start_snmp_trapper = 0
          $server_alert_scripts_path = '/var/lib/zabbixsrv/alertscripts'
          $server_extrernal_scripts  = '/var/lib/zabbixsrv/externalscripts'
        }

        false, default: {
          $agent_package_name        = 'zabbix-agent'
          # TODO - zabbix-server-{sqlite3,mysql,pgsql}
          $server_package_name       = 'zabbix-server'
          # TODO - zabbix-proxy-{sqlite3,mysql,pgsql}
          $proxy_package_name        = 'zabbix-proxy'
          $web_package_name          = 'zabbix-web'
          $server_pid_file           = '/var/run/zabbix/zabbix.pid'
          $server_alert_scripts_path = '/var/lib/zabbix/'
          $server_extrernal_scripts  = '/etc/zabbix/externalscripts'
        }
      }

      $agent_service_name     = 'zabbix-agent'
      $agent_include_folder   = '/etc/zabbix/zabbix_agentd.conf.d'
      $agent_config_file      = '/etc/zabbix/zabbix_agent.conf'
      $agent_config_template  = 'zabbix/zabbix_agent.conf.erb'
      $agentd_config_file     = '/etc/zabbix/zabbix_agentd.conf'
      $agentd_config_template = 'zabbix/zabbix_agentd.conf.erb'
      $server_service_name    = 'zabbix-server'
      $agent_pid_file         = '/var/run/zabbix/zabbix_agentd.pid'
      $agent_log_file         = '/var/log/zabbix/zabbix_agentd.log'
      $agent_log_file_size    = 0
      $agent_include          = '/etc/zabbix/zabbix_agentd.conf.d/'
      $server_log_file        = '/var/log/zabbix/zabbix_server.log'
      $server_log_file_size   = 0
      $server_db_socket       = '/var/lib/mysql/mysql.sock'
      $proxy_pid_file         = '/var/run/zabbix/zabbix_proxy.pid'
      $proxy_log_file         = '/var/log/zabbix/zabbix_proxy.log'
      $proxy_log_file_size    = 0
      $proxy_db_socket        = '/var/lib/mysql/mysql.sock'
    }

    /(SLES|OpenSuSE)/: {
      $agent_package_name     = 'zabbix-agent'
      $agent_service_name     = 'zabbix-agentd'
      $agent_config_file      = '/etc/zabbix/zabbix-agent.conf'
      $agent_config_template  = 'zabbix/sles.zabbix-agent.conf.erb'
      $agentd_config_file     = '/etc/zabbix/zabbix-agentd.conf'
      $agentd_config_template = 'zabbix/sles.zabbix-agentd.conf.erb'
      $server_package_name    = 'zabbix-server'
      $server_service_name    = 'zabbix-server'
      $agentd_pid_file        = '/var/run/zabbix/zabbix-agentd.pid'
      $agentd_log_file        = '/var/log/zabbix/zabbix-agentd.log'
      $agentd_log_file_size   = 1
      $agent_include          = '/etc/zabbix/zabbix-agentd.conf.d/'
      # TODO server variables
      # TODO proxy variables
    }

  }

}
