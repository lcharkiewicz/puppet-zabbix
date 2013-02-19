# == Class: zabbix
#
# Installs zabbix-server and configures it.
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class zabbix::server inherits zabbix {
  include zabbix::server::install, zabbix::server::config, zabbix::server::service
}
