# == Class: zabbix::server::config
#
# RedHat family only!
#
class zabbix::server::config {

  $source_ip         = $zabbix::server::source_ip
  $db_schema         = $zabbix::server::schema
  $ssh_key_location  = $zabbix::server::ssh_key_location
  $include           = $zabbix::server::include
  $java_gateway      = $zabbix::server::java_gateway

  if $::operatingsystem =~ /(RedHat|CentOS|Fedora)/ {
    if $zabbix::server::is_20_version {
      $server_config_file  = $zabbix::params::server20_config_file
      $server_config_template  = $zabbix::params::server20_config_template
    }
    else {
      $server_config_file  = $zabbix::params::server_config_file
      $server_config_template  = $zabbix::params::server_config_template
    }
  }
  else {
      $server_config_file  = $zabbix::params::server_config_file
      $server_config_template  = $zabbix::params::server_config_template
  }

  if $zabbix::params::include {
    file { $zabbix::params::include:
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
    }
  }

  file {$server_config_file:
    ensure  => present,
    owner   => 'zabbixsrv',
    group   => 'zabbix',
    mode    => '0640',
    content => template($server_config_template),
  }

}
