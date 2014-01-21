# == Class: zabbix::agent::install
#
class zabbix::agent::install {

  package { $zabbix::params::agent_package_name:
    ensure => $zabbix::agent::version,
  }

}
