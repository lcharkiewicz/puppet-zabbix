# == Class: zabbix::agent::config
#
class zabbix::agent::config {

  $active_checks  = $zabbix::agent::active_checks
  $source_ip      = $zabbix::agent::source_ip
  $agent_alias    = $zabbix::agent::agent_alias
  $user_parameter = $zabbix::agent::user_parameter

  if $::operatingsystem =~ /(RedHat|CentOS|Fedora)/ {
    if $zabbix::agent::is_20_version {
      $agent_config_file  = $zabbix::params::agent20_config_file
      $agentd_config_file = $zabbix::params::agentd20_config_file
    }
    else {
      $agent_config_file  = $zabbix::params::agent_config_file
      $agentd_config_file = $zabbix::params::agentd_config_file
    }
  }
  else {
      $agent_config_file  = $zabbix::params::agent_config_file
      $agentd_config_file = $zabbix::params::agentd_config_file
  }

  file { $zabbix::params::agent_include:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { $agent_config_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($zabbix::params::agent_config_template),
  }

  file { $agentd_config_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($zabbix::params::agentd_config_template),
  }

}
