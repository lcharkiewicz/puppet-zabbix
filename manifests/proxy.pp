# == Class: zabbix::proxy
#
# Installs zabbix-proxy and cofigures it.
#
# === Parameters
#
# [*zabbix_server*]
#   IP address (or hostname) of Zabbix server.
#   Active proxy will get configuration data from the server.
#   For a proxy in the passive mode this parameter will be ignored.
#
# [*version]
#   Specyfic version of package.
#
# [*enable*]
#   Enable service after installation.
#
# [*start*]
#   Start service after installation.
#
# [*proxy_mode*]
#   Proxy operating mode
#   0 - proxy in the active mode
#   1 - proxy in the passive mode
#
# [*server_port*]
#   Port of Zabbix trapper on Zabbix server.
#   For a proxy in the passive mode this parameter will be ignored.
#
# [*hostname*]
#   Unique, case sensitive Proxy name. Make sure the Proxy name is known to the server!
#   Value is acquired from HostnameItem if undefined.
#
# [*hostname_item*]
#   Item used for generating Hostname if it is undefined.
#   Ignored if Hostname is defined.
#
# [*listen_port*]
#   Listen port for trapper.
#
# [*source_ip*]
#   Source IP address for outgoing connections.
#
# [*log_file*]
#   Name of log file.
#   If not set, syslog is used.
#
# [*log_file_size*]
#   Maximum size of log file in MB.
#   0 - disable automatic log rotation.
#
# [*debug_level*]
#   Specifies debug level
#   0 - no debug
#   1 - critical information
#   2 - error information
#   3 - warnings
#   4 - for debugging (produces lots of information)
#
# [*pid_file*]
#   Name of PID file.
#
# [*db_host*]
#   Database host name.
#   If set to localhost, socket is used for MySQL.
#
# [*db_name*]
#   Database name.
#   For SQLite3 path to database file must be provided. DBUser and DBPassword are ignored.
#
# [*db_user*]
#   Database user. Ignored for SQLite.
#
# [*db_password*]
#   Database password. Ignored for SQLite.
#   Comment this line if no password is used.
#
# [*db_schema*]
#   Schema name. Used for IBM DB2.
#
# [*db_socket*]
#   Path to MySQL socket.
#
# [*proxy_local_buffer*]
#   Proxy will keep data locally for N hours, even if the data have already been synced with the server.
#   This parameter may be used if local data will be used by third party applications.
#
# [*proxy_offline_buffer*]
#   Proxy will keep data for N hours in case if no connectivity with Zabbix Server.
#   Older data will be lost.
#
# [*heartbeat_frequency*]
#   Frequency of heartbeat messages in seconds.
#   Used for monitoring availability of Proxy on server side.
#   0 - heartbeat messages disabled.
#   For a proxy in the passive mode this parameter will be ignored.
#
# [*config_frequency*]
#   How often proxy retrieves configuration data from Zabbix Server in seconds.
#   For a proxy in the passive mode this parameter will be ignored.
#
# [*data_sender_frequency*]
#   Proxy will send collected data to the Server every N seconds.
#   For a proxy in the passive mode this parameter will be ignored.
#
# [*start_pollers*]
#   Number of pre-forked instances of pollers.
#
# [*start_ipmi_pollers*]
#   Number of pre-forked instances of IPMI pollers.
#
# [*start_pollers_unreachable*]
#   Number of pre-forked instances of pollers for unreachable hosts (including IPMI).
#
# [*start_trappers*]
#   Number of pre-forked instances of trappers.
#
# [*start_pingers*]
#   Number of pre-forked instances of ICMP pingers.
#
# [*start_discoverers*]
#   Number of pre-forked instances of discoverers.
#
# [*listen_ip*]
#   List of comma delimited IP addresses that the trapper should listen on.
#   Trapper will listen on all network interfaces if this parameter is missing.
#
# [*housekeeping_frequency*]
#   How often Zabbix will perform housekeeping procedure (in hours).
#   Housekeeping is removing unnecessary information from history, alert, and alarms tables.
#
# [*cache_size*]
#   Size of configuration cache, in bytes.
#   Shared memory size, for storing hosts and items data.
#
# [*start_db_syncers*]
#   Number of pre-forked instances of DB Syncers
#
# [*history_cache_size*]
#   Size of history cache, in bytes.
#   Shared memory size for storing history data.
#
# [*history_text_cache_size*]
#   Size of text history cache, in bytes.
#   Shared memory size for storing character, text or log history data.
#
# [*timeout*]
#   Specifies how long we wait for agent, SNMP device or external check (in seconds).
#
# [*trapper_timeout*]
#   Specifies how many seconds trapper may spend processing new data.
#
# [*unreachable_period*]
#   After how many seconds of unreachability treat a host as unavailable.
#
# [*unavailable_delay*]
#   How often host is checked for availability during the unavailability period, in seconds.
#
# [*unreachable_delay*]
#   How often host is checked for availability during the unreachability period, in seconds.
#
# [*external_scripts*]
#   Location of external scripts
#
# [*fping_location*]
#   Location of fping.
#   Make sure that fping binary has root ownership and SUID flag set.
#
# [*fping6_location*]
#   Location of fping6.
#   Make sure that fping6 binary has root ownership and SUID flag set.
#   Make empty if your fping utility is capable to process IPv6 addresses.
#
# [*ssh_key_location*]
#   Location of public and private keys for SSH checks
#
# [*log_slow_queries*]
#   How long a database query may take before being logged (in milliseconds).
#   0 - don't log slow queries.
#
# [*tmp_dir*]
#   Temporary directory.
#
# [*include*]
#   You may include individual files or all files in a directory in the configuration file.
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
  $proxy_mode                = $zabbix::params::proxy_mode,# general parameters
  $server_port               = $zabbix::params::server_port,
  $hostname                  = $zabbix::params::hostname,
  $hostname_item             = $zabbix::params::hostname_item,
  $listen_port               = $zabbix::params::listen_port,
  $source_ip                 = $zabbix::params::source_ip,
  $log_file                  = $zabbix::params::proxy_log_file,
  $log_file_size             = $zabbix::params::proxy_log_file_size,
  $debug_level               = $zabbix::params::debug_level,
  $pid_file                  = $zabbix::params::proxy_pid_file,
  $db_type                   = 'sqlite3',
  $db_host                   = $zabbix::params::db_host,# TODO type of database
  $db_name                   = $zabbix::params::db_name,# TODO db_schema
  $db_user                   = $zabbix::params::db_user,
  $db_password               = $zabbix::params::db_password,
  # TODO
  $db_schema                 = undef,
  $db_socket                 = $zabbix::params::db_socket,
  $db_port                   = $zabbix::params::db_port,
  $proxy_local_buffer        = $zabbix::params::proxy_local_buffer,# proxy specyfic parameters
  $proxy_offline_buffer      = $zabbix::params::proxy_offline_buffer,
  $heartbeat_frequency       = $zabbix::params::heartbeat_frequency,
  $config_frequency          = $zabbix::params::config_frequency,
  $data_sender_frequency     = $zabbix::params::data_sender_frequency,
  $start_pollers             = $zabbix::params::start_pollers,# advanced parameters
  $start_ipmi_pollers        = $zabbix::params::start_ipmi_pollers,
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
  $external_scripts          = $zabbix::params::proxy_external_scripts,# TODO check it!
  $fping_location            = $zabbix::params::fping_location,
  $fping6_location           = $zabbix::params::fping6_location,
  $ssh_key_location          = $zabbix::params::ssh_key_location,
  $log_slow_queries          = $zabbix::params::log_slow_queries,
  $tmp_dir                   = $zabbix::params::tmp_dir,
  $include                   = $zabbix::params::include
) inherits zabbix::params {

  class { 'zabbix::proxy::install': } ->
  class { 'zabbix::proxy::config': } ~>
  class { 'zabbix::proxy::service': } ->
  Class['zabbix::proxy']

}


