# == Class: zabbix::server
#
# Installs zabbix-server and cofigures it.
#
# === Parameters

# [*node_id*]
#   Unique NodeID in distributed setup.
#   0 - standalone server
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
# [*db_schema*]
#   Schema name. Used for IBM DB2.
#
# [*db_user*]
#   Database user. Ignored for SQLite.
#
# [*db_password*]
#   Database password. Ignored for SQLite.
#   Comment this line if no password is used.
#
# [*db_socket*]
#   Path to MySQL socket.
#
# [*db_port*]
#   Database port when not using local socket. Ignored for SQLite.
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
# [*start_http_pollers*]
#   Number of pre-forked instances of HTTP pollers.
#
# [*listen_ip*]
#   List of comma delimited IP addresses that the trapper should listen on.
#   Trapper will listen on all network interfaces if this parameter is missing.
#
# [*housekeeping_frequency*]
#   How often Zabbix will perform housekeeping procedure (in hours).
#   Housekeeping is removing unnecessary information from history, alert, and alarms tables.
#
# [*max_housekeeper_delete*]
#   The table "housekeeper" contains "tasks" for housekeeping procedure in the format:
#   [housekeeperid], [tablename], [field], [value].
#   No more than 'MaxHousekeeperDelete' rows (corresponding to [tablename], [field], [value])
#   will be deleted per one task in one housekeeping cycle.
#   SQLite3 does not use this parameter, deletes all corresponding rows without a limit.
#   If set to 0 then no limit is used at all. In this case you must know what you are doing!
#
# [*disable_housekeeping*]
#   If set to 1, disables housekeeping.
#
# [*sender_frequency*]
#   How often Zabbix will try to send unsent alerts (in seconds).
#
# [*cache_size*]
#   Size of configuration cache, in bytes.
#   Shared memory size for storing hosts and items data.
#
# [*cache_update_frequency*]
#   How often Zabbix will perform update of configuration cache, in seconds.
#
# [*start_db_syncers*]
#   Number of pre-forked instances of DB Syncers
#
# [*history_cache_size*]
#   Size of history cache, in bytes.
#   Shared memory size for storing history data.
#
# [*trend_cache_size*]
#   Size of trend cache, in bytes.
#   Shared memory size for storing trends data.
#
# [*history_text_cache_size*]
#   Size of text history cache, in bytes.
#   Shared memory size for storing character, text or log history data.
#
# [*node_no_events*]
#   If set to '1' local events won't be sent to master node.
#   This won't impact ability of this node to propagate events from its child nodes.
#
# [*node_no_history*]
#   If set to '1' local history won't be sent to master node.
#   This won't impact ability of this node to propagate history from its child nodes.
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
# [*alert_scripts_path*]
#   Location of custom alert scripts
#
# [*external_scripts*]
#   Location of external scripts
#
# [*fping_location*]
#   Location of fping.
#   Make sure that fping binary has root ownership and SUID flag set.
#
# [*Fping6_Location*]
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
# [*start_proxy_pollers*]
#   Number of pre-forked instances of pollers for passive proxies.
#
# [*proxy_config_frequency*]
#   How often Zabbix Server sends configuration data to a Zabbix Proxy in seconds.
#   This parameter is used only for proxies in the passive mode.
#
# [*proxy_data_frequency*]
#   How often Zabbix Server requests history data from a Zabbix Proxy in seconds.
#   This parameter is used only for proxies in the passive mode.
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class zabbix::server (
  $version                   = 'present',
  $enable                    = true,
  $start                     = true,
  $is_20_version             = true,
  # general parameters
  $node_id                   = $zabbix::params::node_id,
  $listen_port               = $zabbix::params::listen_port,
  $source_ip                 = $zabbix::params::source_ip,
  $log_file                  = $zabbix::params::server_log_file,
  $log_file_size             = $zabbix::params::server_log_file_size,
  $debug_level               = $zabbix::params::debug_level,
  $pid_file                  = $zabbix::params::server_pid_file,
  $db_type                   = $zabbix::params::server_db_type,#sqlite3
  $db_host                   = $zabbix::params::server_db_host,
  $db_name                   = $zabbix::params::server_db_name, # TODO mandatory
  $db_schema                 = $zabbix::params::server_db_schema, #TODO !!!
  $db_user                   = $zabbix::params::server_db_user,
  $db_password               = $zabbix::params::server_db_password,
  $db_socket                 = $zabbix::params::server_db_socket,
  $db_port                   = $zabbix::params::server_db_port,
  # advanced parameters
  $start_pollers             = $zabbix::params::start_pollers,
  $start_ipmi_pollers        = $zabbix::params::start_ipmi_pollers,
  $start_pollers_unreachable = $zabbix::params::start_pollers_unreachable,
  $start_trappers            = $zabbix::params::start_trappers,
  $start_pingers             = $zabbix::params::start_pingers,
  $start_discoverers         = $zabbix::params::start_discoverers,
  $start_http_pollers        = $zabbix::params::start_http_pollers,
  $listen_ip                 = $zabbix::params::listen_ip,
  $housekeeping_frequency    = $zabbix::params::housekeeping_frequency,
  $max_housekeeper_delete    = $zabbix::params::max_housekeeper_delete,
  $disable_housekeeping      = $zabbix::params::disable_housekeeping,
  $sender_frequency          = $zabbix::params::sender_frequency,
  $cache_size                = $zabbix::params::cache_size,
  $cache_update_frequency    = $zabbix::params::cache_update_frequency,
  $start_db_syncers          = $zabbix::params::start_db_syncers,
  $history_cache_size        = $zabbix::params::history_cache_size,
  $trend_cache_size          = $zabbix::params::server_trend_cache_size, #TODO !!!!
  $history_text_cache_size   = $zabbix::params::history_text_cache_size,
  $node_no_events            = $zabbix::params::node_no_events,
  $node_no_history           = $zabbix::params::node_no_history,
  $timeout                   = $zabbix::params::timeout,
  $trapper_timeout           = $zabbix::params::trapper_timeout,
  $unreachable_period        = $zabbix::params::unreachable_period,
  $unavailable_delay         = $zabbix::params::unavailable_delay,
  $unreachable_delay         = $zabbix::params::unreachable_delay,
  $alert_scripts_path        = $zabbix::params::server_alert_scripts_path,
  $external_scripts          = $zabbix::params::external_scripts,
  $fping_location            = $zabbix::params::fping_location,
  $fping6_Location           = $zabbix::params::fping6_location,
  $ssh_key_location          = $zabbix::params::ssh_key_location,
  $log_slow_queries          = $zabbix::params::log_slow_queries,
  $tmp_dir                   = $zabbix::params::tmp_dir,
  $include                   = $zabbix::params::include,
  $start_proxy_pollers       = $zabbix::params::start_proxy_pollers,
  $proxy_config_frequency    = $zabbix::params::proxy_config_frequency,
  $proxy_data_frequency      = $zabbix::params::proxy_data_frequency,
) inherits zabbix::params {

  if $::db_passwd == undef {
    fail('DB password is not defined.')
  }

  class { 'zabbix::server::install': } ->
  class { 'zabbix::server::dbinit': } ->
  class { 'zabbix::server::config': } ~>
  class { 'zabbix::server::service': } ->
  Class['zabbix::server']

}
