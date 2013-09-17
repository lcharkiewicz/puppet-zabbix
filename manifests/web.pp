# only for RHEL at the moment
#
class zabbix::web (
  $server_name = $::fqdn,
  $server_aliases = undef,
  $db_type = 'mysql',
) {

  $package = $db_type ? {
    'mysql' => 'zabbix20-web-mysql',
    'pgsql' => 'zabbix20-web-pgsql',
  }

  package { $package:
    ensure => present,
  }

  file { '/etc/httpd/conf.d/zabbix-vhost.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('zabbix/vhost.conf.erb'),
  }

}
