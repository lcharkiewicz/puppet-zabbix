# Zabbix module for Puppet

This module configures and manages Zabbix services (server / agent / proxy) on Linux (Red Hat / Centos, Ubuntu, SLES) distributions.

WARNING: at the moment only agent is truly tested, server is not testes properly, proxy is in development, web is just simply 'install and copy'.

## Usage

### zabbix::agent
Installs and configures Zabbix Agent. You must provide Zabbix Server address.

    class { 'zabbix::agent': 
        zabbix_server => 'zabbix.example.com'
    }

### zabbix::server
Installs and configures Zabbix Server. You must provide database password.

    class { 'zabbix::server': 
        db_password => 'zabbix'
    }

### zabbix::proxy
Installs and configures Zabbix Proxy. You must provide Zabbix Server address.

    class { 'zabbix::proxy': 
        zabbix_server => 'zabbix.example.com'
    }

### zabbix::web
Installs Zabbix Web and provides vhost file for httpd (Apache). Only for Red Hat family at the moment.

$db_type is 'mysql' by default.

    class { 'zabbix::proxy': 
        server_name => 'zabbix.example.com',
        db_type     => 'mysql'
    }


## Assumptions
+ server and proxy modules assume that mysql/pgsql database and user for it is already created (maybe via proper db module)
+ web module assumes you use httpd (apache) web server


## Supported platforms
+ agent: RHEL/CentOS 6.x, Ubuntu 12.04 and above, SLES 11 SP2 and above
+ proxy: RHEL/CentOS 
+ server: RHEL/CentOS
+ web: RHEL/CentOS


## TODO
+ finish proxy manifests (db init)
+ test different configurations of server and proxy module
+ write better docs (examples, params etc.)
+ Windows support (for agent at least)
+ maybe rspec tests? ;)
+ beautify the code ;) (possibly too complex now)
