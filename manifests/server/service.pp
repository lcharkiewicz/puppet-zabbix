# == Class: zabbix::server::service
#
# RedHat family only!
#
class zabbix::server::service {

  $ensure = $zabbix::server::start ? {
    true => running, false => stopped, default => running
  }

  service { $zabbix::params::server_service_name:
    ensure      => $ensure,
    #hassstatus => true,
    #hasrestart => true,
    enable      => $zabbix::server::enable,
  }

}
