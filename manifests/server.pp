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
# [*maxhousekeeper_delete*]
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
class zabbix::agent (
  $zabbix_server          = $zabbix::params::agent_server,
  $zabbix_server_active   = $zabbix::params::agent_server_active,
  $version                = 'present',
  $enable                 = true,
  $start                  = true,
  $is_20_version          = true,
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

