# == Class: zabbix::proxy::install
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
