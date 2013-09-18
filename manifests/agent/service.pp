# == Class: zabbix::agent:service
#
class zabbix::agent::service {

  $ensure = $zabbix::agent::start ? {
    true => running, false => stopped, default => running
  }

  service { $zabbix::params::agent_service_name:
    ensure      => $ensure,
    #hassstatus => true,
    #hasrestart => true,
    enable      => $zabbix::agent::enable,
  }

}
