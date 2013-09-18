# == Class: zabbix::agent
#
# Installs zabbix-agent and cofigures it.
#
# === Parameters
#
# [*zabbix_server*]
#   List of comma delimited IP addresses (or hostnames) of Zabbix servers.
#   No spaces allowed. If ServerActive is not specified, the first entry is used
#   for receiving list of and sending active checks.
#   If IPv6 support is enabled then '127.0.0.1', '::127.0.0.1', '::ffff:127.0.0.1' are treated equally.
#
# [*zabbix_server_active*]
#   Comma-separated list of host:port pairs of Zabbix servers for active checks.
#   If ServerActive is specified, first host in the Server option is not used for active checks, only for passive checks.
#   If the port is not specified, ServerPort port is used for that host. If ServerPort is not specified, default port is used.
#   IPv6 addresses must be enclosed in square brackets if port for that host is specified.
#   If port is not specified, square brackets for IPv6 addresses are optional.
#   Example: ServerActive=127.0.0.1:20051,zabbix.domain,[::1]:30051,::1,[12fc::1]
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
# [*is_20_version*]
#   Install Zabbix 2.0 (currently related only with Red Hat family)
#
# [*pid_file*]
#   Name of PID file.
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
# [*source_ip*]
#   Source IP address for outgoing connections.
#
# [*enable_remote_commands*]
#   Whether remote commands from Zabbix server are allowed.
#   0 - not allowed
#   1 - allowed
#
# [*log_remote_commands*]
#   Enable logging of executed shell commands as warnings.
#   0 - disabled
#   1 - enabled
#
# [*hostname*]
#   Unique, case sensitive hostname.
#   Required for active checks and must match hostname as configured on the server.
#   Value is acquired from HostnameItem if undefined.
#
# [*hostname_item*]
#   Item used for generating Hostname if it is undefined.
#   Ignored if Hostname is defined.
#
# [*listen_port*]
#   Agent will listen on this port for connections from the server.
#
# [*listen_ip*]
#   List of comma delimited IP addresses that the agent should listen on.
#
# [*refresh_active_checks*]
#   How often list of active checks is refreshed, in seconds.
#
# [*buffer_send*]
#   Do not keep data longer than N seconds in buffer.
#
# [*buffer_size*]
#   Maximum number of values in a memory buffer. The agent will send
#   all collected data to Zabbix Server or Proxy if the buffer is full.
#
# [*max_lines_per_second*]
#   Maximum number of new lines the agent will send per second to Zabbix Server
#   or Proxy processing 'log' and 'logrt' active checks.
#   The provided value will be overridden by the parameter 'maxlines',
#   provided in 'log' or 'logrt' item keys.
#
# [*allow_root*]
#   Allow the agent to run as 'root'. If disabled and the agent is started by 'root', the agent
#   will try to switch to user 'zabbix' instead. Has no effect if started under a regular user.
#   0 - do not allow
#   1 - allow
#
# [*include*]
#   You may include individual files or all files in a directory in the configuration file.
#
# [*agent_alias*]
#   Sets an alias for parameter. It can be useful to substitute long and complex parameter name with a smaller and simpler one.
#
# [*start_agents*]
#   Number of pre-forked instances of zabbix_agentd that process passive checks.
#
# [*timeout*]
#   Spend no more than Timeout seconds on processing
#
# [*unsafe_user_parameters*]
#   Allow all characters to be passed in arguments to user-defined parameters.
#   0 - do not allow
#   1 - allow
#
# [*user_parameter*]
#   User-defined parameter to monitor. There can be several user-defined parameters.
#   Format: UserParameter=<key>,<shell command>
#   Note that shell command must not return empty string or EOL only.
#   See 'zabbix_agentd' directory for examples.
#
# === Authors
#
# Leszek Charkiewicz <leszek@charkiewicz.net>
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
  $hostname_item          = $zabbix::params::hostname_item,#commented in template
  $listen_port            = $zabbix::params::agent_listen_port,
  $listen_ip              = $zabbix::params::listen_ip,
  # active checks
  $refresh_active_checks  = $zabbix::params::refresh_active_checks,
  $buffer_send            = $zabbix::params::buffer_send,
  $buffer_size            = $zabbix::params::buffer_size,
  $max_lines_per_second   = $zabbix::params::max_lines_per_second,
  $allow_root             = $zabbix::params::allow_root,
  # advanced parameters
  $include                = $zabbix::params::agent_include,
  $agent_alias            = $zabbix::params::alias,
  $start_agents           = $zabbix::params::start_agents,
  $timeout                = $zabbix::params::timeout,
  # user defined monitored parameters
  $unsafe_user_parameters = $zabbix::params::unsafe_user_parameters,
  $user_parameter         = $zabbix::params::user_parameter
) inherits zabbix::params {

  class { 'zabbix::agent::install': } ->
  class { 'zabbix::agent::config': } ~>
  class { 'zabbix::agent::service': } ->
  Class['zabbix::agent']

}
