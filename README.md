# Zabbix module for Puppet

This module configures and manages Zabbix services (server / agent / proxy) on Linux (Red Hat / Centos, Ubuntu, SLES) distributions.

WARNING: at the moment only agent is truly tested, proxy is in development, server is a mess. 

## Usage

### zabbix::agent
Installs and configures Zabbix Agent. You must provide Zabbix Server address.

    class { 'zabbix::agent': 
        zabbix_server => 'zabbix.example.com'
    }

### zabbix::server
Installs and configures Zabbix Server.

    class { 'zabbix::server': }

### zabbix::proxy
Installs and configures Zabbix Proxy. You must provide Zabbix Server address.

    class { 'zabbix::proxy': 
        zabbix_server => 'zabbix.example.com'
    }

