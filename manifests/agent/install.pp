# == Class: zabbix::agent::install
#
class zabbix::agent::install {

  if $::operatingsystem =~ /(RedHat|CentOS|Fedora)/ {
    if $zabbix::agent::is_20_version {
      $package_name = $zabbix::params::agent20_package_name
    }
    else {
      $package_name = $zabbix::params::agent_package_name
    }
  }
  else {
      $package_name = $zabbix::params::agent_package_name
  }

  package { $package_name:
    ensure => $zabbix::agent::version,
  }

}
