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
  ### General parameters
  $agent_debug_level           = 3
  $agent_source_ip              = ''
  $agent_enable_remote_commands = 0
  $agent_log_remote_commands    = 0
  $agent_hostname               = $::hostname # passive checks
  $agent_hostname_item          = 'system.hostname'
  $agent_listen_port            = 10050
  $agent_listen_ip              = '0.0.0.0'
  $agent_refresh_active_checks  = 120 # active checks
  $agent_buffer_send            = 5
  $agent_buffer_size            = 100
  $agent_max_lines_per_second   = 100
  $agent_allow_root             = 0
  $agent_alias                  = '' # advanced params
  $agent_start_agents           = 3
  $agent_timeout                = 3
  $agent_unsafe_user_parameters = 0 # user defined monitored parameters
  $agent_user_parameter         = ''

  # Server jest brany z $zabbix_server
  # TODO - add if which would set ServerActive
  # Hostname jest brany z $::hostname
  # TODO - add if (hostname or fqdn)

  case $::operatingsystem {
    default,/(Ubuntu|Debian)/: {
      $agent_package_name = 'zabbix-agent'
      $agent_service_name = 'zabbix-agentd'
      $agent_config_file = '/etc/zabbix/zabbix-agent.conf'
      $agentd_config_file = '/etc/zabbix/zabbix-agentd.conf'
      $agentd_config_template = 'zabbix/ubuntu.zabbix_agentd.conf.erb'
      $server_package_name = 'zabbix-server'
      $server_service_name = 'zabbix-server'
      ### General parameters
      $agentd_pid_file = "/var/run/zabbix/zabbix_agentd.pid"
      $agentd_log_file = "/var/log/zabbix/zabbix_agentd.log"
      $agentd_log_file_size = 0
      # passive checks 
      $agent_disable_passive = 0
      # active checks
      # brakuje TODO $agent_server_active - podany w parametrze
      $agent_disable_active = 0
      $agent_server_port = 10051
      # advanced params
      $agent_include = '/etc/zabbix/zabbix_agentd.conf.d/'
    }

    /(RedHat|CentOS|Fedora)/: {
      # if 2.0 zabbix20-agent etc. TODO
      $agent_package_name = 'zabbix-agent'
      $agent_service_name = 'zabbix-agent'
      $agent_include_folder = '/etc/zabbix/zabbix_agentd.conf.d'
      $agent_config_file = '/etc/zabbix/zabbix_agent.conf'
      #$zabbix_agent_config_template = 'zabbix/centos.zabbix_agent.conf.erb'
      $agent_config_template = 'zabbix/zabbix_agent.conf.erb'
      $agentd_config_file = '/etc/zabbix/zabbix_agentd.conf'
      #$zabbix_agentd_config_template = 'zabbix/centos.zabbix_agentd.conf.erb'
      $agentd_config_template = 'zabbix/zabbix_agentd.conf.erb'
      $server_package_name = 'zabbix-server'
      $server_service_name = 'zabbix-server'
      ### General parameters
      $agent_pid_file = "/var/run/zabbix/zabbix_agentd.pid"
      $agent_log_file = "/var/log/zabbix/zabbix_agentd.log"
      $agent_log_file_size = 0
      # advanced params
      $agent_include = '/etc/zabbix/zabbix_agentd.conf.d/'
    }

    /(SLES|OpenSuSE)/: {
      $agent_package_name = 'zabbix-agent'
      $agent_service_name = 'zabbix-agentd'
      $agent_config_file = '/etc/zabbix/zabbix-agent.conf'
      $agent_config_template = 'zabbix/sles.zabbix-agent.conf.erb'
      $agentd_config_file = '/etc/zabbix/zabbix-agentd.conf'
      $agentd_config_template = 'zabbix/sles.zabbix-agentd.conf.erb'
      $server_package_name = 'zabbix-server'
      $server_service_name = 'zabbix-server'

      ### General parameters
      $agentd_pid_file = "/var/run/zabbix/zabbix-agentd.pid"
      $agentd_log_file = "/var/log/zabbix/zabbix-agentd.log"
      $agentd_log_file_size = 1
      # advanced params
      $agent_include = '/etc/zabbix/zabbix-agentd.conf.d/'
    }

  }

}
