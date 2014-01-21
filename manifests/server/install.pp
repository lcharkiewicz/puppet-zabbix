# == Class: zabbix::server::install
#
# RedHat family only!
#
# TODO
# install mysql/pgsql package for connecting database
class zabbix::server::install (
){

  $db_type = $zabbix::server::db_type

  package { "${zabbix::params::server_package_name}-${db_type}":
    ensure => $zabbix::server::version,
  }

}
