# == Class: zabbix::server::config
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
class zabbix::server::config {

  $source_ip        = $zabbix::server::source_ip
  $db_password      = $zabbix::server::db_password
  $ssh_key_location = $zabbix::server::ssh_key_location
  $include          = $zabbix::server::include

  if $::operatingsystem =~ /(RedHat|CentOS|Fedora)/ {
    if $zabbix::server::is_20_version {
      $server_config_file  = $zabbix::params::server20_config_file
    }
    else {
      $server_config_file  = $zabbix::params::server_config_file
    }
  }
  else {
      $server_config_file  = $zabbix::params::server_config_file
  }

  if $zabbix::server::db_type == 'sqlite3' {
    if  $zabbix::server::db_name == 'zabbix' {
      $db_name = $zabbix::params::db_name_sqlite
    } 
  } 

  file { $zabbix::params::include:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { $zabbix::params::server_config_file:
# TODO server20_config_file?
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($server_config_template),
  }

}
