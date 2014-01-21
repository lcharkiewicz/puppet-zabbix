# == Class: zabbix::repo
#
# Adds Zabbix repositories.
#
# === Parameters
#
# [*zabbix_server*]
#   List of comma delimited IP addresses (or hostnames) of Zabbix servers.
#   No spaces allowed. If ServerActive is not specified, the first entry is used
#   for receiving list of and sending active checks.
#   If IPv6 support is enabled then '127.0.0.1', '::127.0.0.1', '::ffff:127.0.0.1' are treated equally.
#
# [*zabbix_server_active*]
#   Comma-separated list of host:port pairs of Zabbix servers for active checks.
#   If ServerActive is specified, first host in the Server option is not used for active checks, only for passive checks.
#   If the port is not specified, ServerPort port is used for that host. If ServerPort is not specified, default port is used.
#   IPv6 addresses must be enclosed in square brackets if port for that host is specified.
#   If port is not specified, square brackets for IPv6 addresses are optional.
#   Example: ServerActive=127.0.0.1:20051,zabbix.domain,[::1]:30051,::1,[12fc::1]
#
# [*version]
#   Specyfic version of package.
#
# [*enable*]
#   Enable service after installation.
#
# [*start*]
#   Start service after installation.
#
#
#
# === Authors
#
# Leszek Charkiewicz <leszek@charkiewicz.net>
#
class zabbix::repo {

  case $::operatingsystem {

    /(RedHat|CentOS|Fedora)/: {
      yumrepo{ 'zabbix':
        descr    => "Zabbix Official Repository - ${::architecture}",
        baseurl  => 'http://repo.zabbix.com/zabbix/2.2/rhel/6/$basearch/',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
      }
      yumrepo{ 'zabbix_non_supported':
        descr    => "Zabbix Official Repository non-supported - ${::architecture}",
        baseurl  => 'http://repo.zabbix.com/non-supported/rhel/6/$basearch/',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
      }
    }
    /(Ubuntu|Debian)/: {
      fail("${::operatingsystem} is not supported yet!")
    }
    default: {
      fail("${::operatingsystem} is not supported yet!")
    }

  }
}
