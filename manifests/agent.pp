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
  $zabbix_server,
  # TODO
  # check is_active and then eventually uncomment it in cfg 
  # $zabbix_server_active
  # TODO
  # think about non-daemon version and snmptrap in Centos
  $version                = "present",
  $enable                 = true,
  $start                  = true,
  $pid_file               = $zabbix::params::agent_pid_file, # general parameters
  $log_file               = $zabbix::params::agent_log_file,
  $log_file_size          = $zabbix::params::agent_log_file_size,
  $debug_level            = $zabbix::params::agent_debug_level,
  $source_ip              = $zabbix::params::agent_source_ip,
  $enable_remote_commands = $zabbix::params::agent_enable_remote_commands,
  $log_remote_commands    = $zabbix::params::agent_log_remote_commands,
  $hostname               = $zabbix::params::agent_hostname, # passive checks
  $hostname_item          = $zabbix::params::agent_hostname_item,
  $listen_port            = $zabbix::params::agent_listen_port,
  $listen_ip              = $zabbix::params::agent_listen_ip,
  $refresh_active_checks  = $zabbix::params::agent_refresh_active_checks, #active checks
  $buffer_send            = $zabbix::params::agent_buffer_send,
  $buffer_size            = $zabbix::params::agent_buffer_size,
  $max_lines_per_second   = $zabbix::params::agent_max_lines_per_second,
  $allow_root             = $zabbix::params::agent_allow_root,
  $include                = $zabbix::params::agent_include, #advanced params
  $agent_alias            = $zabbix::params::agent_alias,
  $start_agents           = $zabbix::params::agent_start_agents,
  $timeout                = $zabbix::params::agent_timeout,
  $unsafe_user_parameters = $zabbix::params::agent_unsafe_user_parameters, # user defined monitored parameters
  $user_parameters        = $zabbix::params::agent_user_parameters
) inherits zabbix::params {

  class { 'zabbix::agent::install': } ->
  class { 'zabbix::agent::config': } ~>
  class { 'zabbix::agent::service': } ->
  Class["zabbix::agent"]

}
