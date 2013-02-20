# == Class: zabbix
#
# Installs zabbix-agent and cofigures it.
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class zabbix::agent (
  $zabbix_server          = $zabbix::params::agent_server,
  $zabbix_server_active   = $zabbix::params::agent_server_active,
  $version                = 'present',
  $enable                 = true,
  $start                  = true,
  # general parameters
  $pid_file               = $zabbix::params::agent_pid_file,
  $log_file               = $zabbix::params::agent_log_file,
  $log_file_size          = $zabbix::params::agent_log_file_size,
  $debug_level            = $zabbix::params::agent_debug_level,
  $source_ip              = $zabbix::params::agent_source_ip,
  $enable_remote_commands = $zabbix::params::agent_enable_remote_commands,
  $log_remote_commands    = $zabbix::params::agent_log_remote_commands,
  # passive checks
  $hostname               = $zabbix::params::agent_hostname,
  $hostname_item          = $zabbix::params::agent_hostname_item,
  $listen_port            = $zabbix::params::agent_listen_port,
  $listen_ip              = $zabbix::params::agent_listen_ip,
  # active checks
  $refresh_active_checks  = $zabbix::params::agent_refresh_active_checks,
  $buffer_send            = $zabbix::params::agent_buffer_send,
  $buffer_size            = $zabbix::params::agent_buffer_size,
  $max_lines_per_second   = $zabbix::params::agent_max_lines_per_second,
  $allow_root             = $zabbix::params::agent_allow_root,
  # advanced params
  $include                = $zabbix::params::agent_include,
  $agent_alias            = $zabbix::params::agent_alias,
  $start_agents           = $zabbix::params::agent_start_agents,
  $timeout                = $zabbix::params::agent_timeout,
  # user defined monitored parameters
  $unsafe_user_parameters = $zabbix::params::agent_unsafe_user_parameters,
  $user_parameter        = $zabbix::params::agent_user_parameter
) inherits zabbix::params {

  class { 'zabbix::agent::install': } ->
  class { 'zabbix::agent::config': } ~>
  class { 'zabbix::agent::service': } ->
  Class['zabbix::agent']

}
