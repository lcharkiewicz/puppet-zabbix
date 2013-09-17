#
class zabbix::server::dbinit (
  $db_type = $zabbix::server::db_type,
  $db_host = $zabbix::server::db_host,
  $db_name = $zabbix::server::db_name,
  $db_user = $zabbix::server::db_user,
  $db_password = $zabbix::server::db_password,
) {

  case $db_type {

    default,'mysql': {
      exec {'init db - schema':
        command => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} < /usr/share/zabbix-mysql/schema.sql",
        unless  => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} -e 'DESCRIBE maintenances'",
      } ->
      exec {'init db - images':
        command => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} < /usr/share/zabbix-mysql/images.sql",
        unless  => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} -e 'SELECT name FROM images' | grep -q Cloud",
      } ->
      exec {'init db - data':
        command => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} < /usr/share/zabbix-mysql/data.sql",
        unless  => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} -e 'SELECT name FROM hosts;' | grep -q Template",
      }
    }

    # TODO
    'pgsql': {
      exec {'init db - schema':
        command => "/usr/bin/pgsql -h ${db_host} -u ${db_user} -p ${db_password} ${db_name} < /usr/share/zabbix-pgsql/schema.sql",
        #unless  => ""
      } ->
      exec {'init db - images':
        command => "/usr/bin/pgsql -h ${db_host} -u ${db_user} -p ${db_password} ${db_name} < /usr/share/zabbix-pgsql/images.sql",
        #unless  => "",
      } ->
      exec {'init db - data':
        command => "/usr/bin/pgsql -h ${db_host} -u ${db_user} -p ${db_password} ${db_name} < /usr/share/zabbix-pgsql/data.sql",
        #unless  => "",
      }
    }

  }

}
