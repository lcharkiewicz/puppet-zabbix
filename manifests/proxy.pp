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
  $zabbix_server             = $zabbix::params::zabbix_server,
  $version                   = 'present',
  $enable                    = true,
  $start                     = true,
  $is_20_version             = true,
  $proxy_mode                = $zabbix::params::proxy_mode# general parameters
  $server_port               = $zabbix::params::server_port
  $hostname                  = $zabbix::params::hostname
  $hostname_item             = $zabbix::params::hostname_item
  $listen_port               = $zabbix::params::listen_port
  $source_ip                 = $zabbix::params::source_ip
  $log_file                  = $zabbix::params::proxy_log_file
  $log_file_size             = $zabbix::params::proxy_log_file_size
  $debug_level               = $zabbix::params::debug_level
  $pid_file                  = $zabbix::params::proxy_pid_file
  $db_host                   = $zabbix::params::db_host# TODO type of database
  $db_name                   = $zabbix::params::db_name# TODO db_schema
  $db_user                   = $zabbix::params::db_user
  $db_password               = $zabbix::params::db_password
  $db_socket                 = $zabbix::params::db_socket
  $db_port                   = $zabbix::params::db_port
  $proxy_local_buffer        = $zabbix::params::proxy_local_buffer# proxy specyfic parameters
  $proxy_offline_buffer      = $zabbix::params::proxy_offline_buffer
  $heartbeat_frequency       = $zabbix::params::heartbeat_frequency
  $config_frequency          = $zabbix::parmas::config_frequency
  $data_sender_frequency     = $zabbix::params::data_sender_frequency
  $start_pollers             = $zabbix::params::start_pollers# advanced parameters
  $start_ipmi_pollers        = $zabbix::params::start_ipmi_pollers
  $start_pollers_unreachable = $zabbix::params::start_pollers_unreachable,
  $start_trappers            = $zabbix::params::start_trappers,
  $start_pingers             = $zabbix::params::start_pingers,
  $start_discoverers         = $zabbix::params::start_discoverers,
  $listen_ip                 = $zabbix::params::listen_ip,
  $housekeeping_frequency    = $zabbix::params::housekeeping_frequency,
  $cache_size                = $zabbix::params::cache_size,
  $start_db_syncers          = $zabbix::params::start_db_syncers,
  $history_cache_size        = $zabbix::params::history_cache_size,
  $history_text_cache_size   = $zabbix::params::history_text_cache_size,
  $timeout                   = $zabbix::params::timeout,
  $trapper_timeout           = $zabbix::params::trapper_timeout,
  $unreachable_period        = $zabbix::params::unreachable_period,
  $unavailable_delay         = $zabbix::params::unavailable_delay,
  $unreachable_delay         = $zabbix::params::unreachable_delay,
  $external_scripts          = $zabbix::params::proxy_external_scripts# TODO check it!
  $fping_location            = $zabbix::params::fping_location,
  $fping6_location           = $zabbix::params::fping6_location,
  $ssh_key_location          = $zabbix::params::ssh_key_location,
  $log_slow_queries          = $zabbix::params::log_slow_queries,
  $tmp_dir                   = $zabbix::params::tmp_dir,
  $include                   = $zabbix::params::include,
) inherits zabbix::params {

  class { 'zabbix::proxy::install': } ->
  class { 'zabbix::proxy::config': } ~>
  class { 'zabbix::proxy::service': } ->
  Class['zabbix::proxy']

}
