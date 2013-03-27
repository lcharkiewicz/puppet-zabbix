# == Class: zabbix::proxy::install
#
# Full description of class zabbix here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { zabbix:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class zabbix::proxy::install {

  if $::operatingsystem =~ /(RedHat|CentOS|Fedora)/ {
    if $zabbix::proxy::is_20_version {
      $package_name = "${zabbix::params::proxy20_package_name}-${zabbix::proxy::db_type}"
    }
    else {
      $package_name = "${zabbix::params::proxy_package_name}-${zabbix::proxy::db_type}"
    }
  }
  else {
    $package_name = $zabbix::params::proxy_package_name
  }

  case $zabbix::proxy::db_type {
    'sqlite3': {
      if  $zabbix::proxy::db_name == 'zabbix' {
        $db_name = $zabbix::params::db_name_sqlite3
      }
      else {
        $db_name = $zabbix::proxy::db_name
      }

      $command = "sqlite3 ${db_name} < /usr/share/doc/zabbix-proxy-sqlite3-*/create/schema/sqlite.sql"
      $creates = $db_name
    }
    'mysql': {
      $command = "mysql -u root ${zabbix::proxy::db_name} < /usr/share/doc/zabbix-proxy-sqlite3-*/create/schema/sqlite.sql"
    }
    'postgres': {
      $command = "mysql -u root ${zabbix::proxy::db_name} < /usr/share/doc/zabbix-proxy-*/create/schema/schema.sql"
    }
    default: {
      fail('Wrong database type!')
    }
  }

  package { $package_name:
    ensure => $zabbix::proxy::version,
    # before => Exec['proxy_db_init']
  } ->

  exec {'proxy_db_init':
    command   => $command,
    provider  => 'shell',
    # onlyif  => "redhat equivalent of: dpkg --get-selections | grep zabbix-proxy"
    # creates => $db_name,
    path      => '/usr/bin:/usr/local/bin',
    # require => Package[$package_name]
  }

  # init (via exec)
  # === Sqlite
  # sqlite3 /var/lib/sqlite/zabbix.db < /usr/doc/zabbix-proxy-${version}/create/schema/schema.sql
  # === MySQL
  # shell> mysql -u<username> -p<password>
  # mysql> create database zabbix character set utf8;
  # mysql> quit;
  # shell> mysql -u<username> -p<password> zabbix < database/mysql/schema.sql
  # PostgreSQL
  # hell> psql -U <username>
  # psql> create database zabbix;
  # psql> \q
  # shell> cd database/postgresql
  # shell> psql -U <username> zabbix < schema.sql

}
