# == Class: zabbix::agent::config
#
class zabbix::agent::config {

  $source_ip            = $zabbix::agent::source_ip
  $zabbix_server_active = $zabbix::agent::zabbix_server_active
  $host_metadata        = $zabbix::agent::host_metadata
  $host_metadata_item   = $zabbix::agent::host_metadata_item
  $agent_alias          = $zabbix::agent::agent_alias
  $user_parameter       = $zabbix::agent::user_parameter
  $load_module          = $zabbix::agent::load_module

  file { $zabbix::params::agent_include:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { $zabbix::params::agent_config_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($zabbix::params::agent_config_template),
  }

}
