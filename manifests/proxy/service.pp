# == Class: zabbix::proxy:service
#
class zabbix::proxy::service {

  $ensure = $zabbix::proxy::start ? {
    true => running, false => stopped, default => running
  }

  service { $zabbix::params::proxy_service_name:
    ensure      => $ensure,
    #hassstatus => true,
    #hasrestart => true,
    enable      => $zabbix::proxy::enable,
  }

}
