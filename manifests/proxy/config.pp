# == Class: zabbix::proxy::config
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
class zabbix::proxy::config {

  $source_ip        = $zabbix::proxy::source_ip
  $db_schema        = $zabbix::proxy::db_schema
  $db_password      = $zabbix::proxy::db_password
  $ssh_key_location = $zabbix::proxy::ssh_key_location
  $include          = $zabbix::proxy::include

  if $::operatingsystem =~ /(RedHat|CentOS|Fedora)/ {
    if $zabbix::proxy::is_20_version {
      $proxy_config_file = $zabbix::params::proxy20_config_file
      $agentd_config_file = $zabbix::params::agentd20_config_file

      # file { $agentd_config_file:
      #   ensure  => present,
      #   owner   => 'root',
      #   group   => 'root',
      #   mode    => '0644',
      #   content => template($zabbix::params::agentd_config_template),
      # }
    }
    else {
      $proxy_config_file = $zabbix::params::proxy_config_file
    }
  }
  else {
    $proxy_config_file = $zabbix::params::proxy_config_file
  }

  #  file { $zabbix::params::include:
  #    ensure  => directory,
  #    owner   => 'root',
  #    group   => 'root',
  #    mode    => '0755',
  #  } ->

  file { $proxy_config_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($zabbix::params::proxy_config_template),
  }


}
