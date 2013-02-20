# == Class: zabbix::agent
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
  $zabbix_server          = $zabbix::params::zabbix_server,
  $zabbix_server_active   = $zabbix::params::zabbix_server_active,
  $version                = 'present',
  $enable                 = true,
  $start                  = true,
  $is_20_version          = true,
  # general parameters
  $pid_file               = $zabbix::params::agent_pid_file,
  $log_file               = $zabbix::params::agent_log_file,
  $log_file_size          = $zabbix::params::agent_log_file_size,
  $debug_level            = $zabbix::params::debug_level,
  $source_ip              = $zabbix::params::source_ip,
  $enable_remote_commands = $zabbix::params::enable_remote_commands,
  $log_remote_commands    = $zabbix::params::log_remote_commands,
  # passive checks
  $hostname               = $zabbix::params::hostname,
  $hostname_item          = $zabbix::params::hostname_item,
  $listen_port            = $zabbix::params::agent_listen_port,
  $listen_ip              = $zabbix::params::listen_ip,
  # active checks
  $refresh_active_checks  = $zabbix::params::refresh_active_checks,
  $buffer_send            = $zabbix::params::buffer_send,
  $buffer_size            = $zabbix::params::buffer_size,
  $max_lines_per_second   = $zabbix::params::max_lines_per_second,
  $allow_root             = $zabbix::params::allow_root,
  # advanced params
  $include                = $zabbix::params::agent_include,
  $agent_alias            = $zabbix::params::alias,
  $start_agents           = $zabbix::params::start_agents,
  $timeout                = $zabbix::params::timeout,
  # user defined monitored parameters
  $unsafe_user_parameters = $zabbix::params::unsafe_user_parameters,
  $user_parameter        = $zabbix::params::user_parameter
) inherits zabbix::params {

  class { 'zabbix::agent::install': } ->
  class { 'zabbix::agent::config': } ~>
  class { 'zabbix::agent::service': } ->
  Class['zabbix::agent']

}
