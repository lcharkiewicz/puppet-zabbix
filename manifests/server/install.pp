# == Class: zabbix::server::install
#
# RedHat family only!
#
class zabbix::server::install {

  if $::operatingsystem =~ /(RedHat|CentOS|Fedora)/ {
    if $zabbix::server::is_20_version {
      $package_name = "${zabbix::params::server20_package_name}-${zabbix::server::db_type}"
    }
    else {
      $package_name = "${zabbix::params::server_package_name}-${zabbix::server::db_type}"
    }
  }
  else {
      $package_name = "${zabbix::params::server_package_name}-${zabbix::server::db_type}"
  }

  package { $package_name:
    ensure => $zabbix::server::version,
  }

}
