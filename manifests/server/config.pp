# == Class: zabbix::server::config
#
# RedHat family only! TODO
#
class zabbix::server::config {

  $source_ip         = $zabbix::server::source_ip
  $db_schema         = $zabbix::server::schema
  $java_gateway      = $zabbix::server::java_gateway
  $ssh_key_location  = $zabbix::server::ssh_key_location
  $include           = $zabbix::server::server_include
  $load_module       = $zabbix::server::load_module

  file { $zabbix::params::server_include:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file {$zabbix::params::server_config_file:
    ensure  => present,
    owner   => 'zabbix',
    group   => 'zabbix',
    mode    => '0640',
    content => template($zabbix::params::server_config_template),
  }

}
