# == Class: zabbix::proxy
#
# Installs zabbix-proxy and cofigures it.
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class zabbix::proxy (
  $zabbix_server          = $zabbix::params::zabbix_server,
  $version                = 'present',
  $enable                 = true,
  $start                  = true,
  $is_20_version          = true,
  # general parameters
  $proxy_mode
  $server_port
  $hostname
  $hostname_item
  $listen_port
  $source_ip
  $log_file
  $log_file_size
  $debug_level
  $pid_file
  # TODO type of database
  $db_host
  $db_name
  # TODO db_schema
  $db_user
  $db_password
  $db_socket
  $db_port
  # proxy specyfic parameters
  $proxy_local_buffer
  $proxy_offline_buffer
  $heartbeat_frequency
  $config_frequency
  $data_sender_frequency
  # advanced parameters
  $start_pollers
  $start_ipmi_pollers
  $start_pollers_unreachable
  $start_trappers
  $start_pingers
  $start_discoverers
  $listen_ip
  $housekeeping_frequency
  $cache_size
  $start_db_syncers
  $history_cache_size
  $history_text_cache_size
  $timeout
  $trapper_timeout
  $unreachable_period
  $unavailable_delay
  $unreachable_delay
  $external_scripts
  $fping_location
  $fping6_location
  $ssh_key_location
  $log_slow_queries
  $tmp_dir
  $include

  $pid_file               = $zabbix::params::proxy_pid_file,
  $log_file               = $zabbix::params::proxy_log_file,
  $log_file_size          = $zabbix::params::proxy_log_file_size,
  $debug_level            = $zabbix::params::debug_level,
  $source_ip              = $zabbix::params::source_ip,
  $enable_remote_commands = $zabbix::params::enable_remote_commands,
  $log_remote_commands    = $zabbix::params::log_remote_commands,
  # passive checks
  $hostname               = $zabbix::params::hostname,
  $hostname_item          = $zabbix::params::hostname_item,
  $listen_port            = $zabbix::params::proxy_listen_port,
  $listen_ip              = $zabbix::params::listen_ip,
  # active checks
  $refresh_active_checks  = $zabbix::params::refresh_active_checks,
  $buffer_send            = $zabbix::params::buffer_send,
  $buffer_size            = $zabbix::params::buffer_size,
  $max_lines_per_second   = $zabbix::params::max_lines_per_second,
  $allow_root             = $zabbix::params::allow_root,
  # advanced params
  $include                = $zabbix::params::proxy_include,
  $proxy_alias            = $zabbix::params::alias,
  $start_proxys           = $zabbix::params::start_proxys,
  $timeout                = $zabbix::params::timeout,
  # user defined monitored parameters
  $unsafe_user_parameters = $zabbix::params::unsafe_user_parameters,
  $user_parameter        = $zabbix::params::user_parameter
) inherits zabbix::params {

  class { 'zabbix::proxy::install': } ->
  class { 'zabbix::proxy::config': } ~>
  class { 'zabbix::proxy::service': } ->
  Class['zabbix::proxy']

}
