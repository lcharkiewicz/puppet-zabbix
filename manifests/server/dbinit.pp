#
class zabbix::server::dbinit (
  $db_type = $zabbix::server::db_type,
  $db_host = $zabbix::server::db_host,
  $db_name = $zabbix::server::db_name,
  $db_user = $zabbix::server::db_user,
  $db_password = $zabbix::server::db_password,
) {

  case $db_type {

    'mysql': {
      exec {'init db - schema':
        command => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p ${db_password} ${db_name} < /usr/share/zabbix-mysql/schema.sql"
      } ->
      exec {'init db - images':
        command => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p ${db_password} ${db_name} < /usr/share/zabbix-mysql/images.sql"
      } ->
      exec {'init db - data':
        command => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p ${db_password} ${db_name} < /usr/share/zabbix-mysql/data.sql"
      }
    }

    'pgsql': {
      exec {'init db - schema':
        command => "/usr/bin/pgsql -h ${db_host} -u ${db_user} -p ${db_password} ${db_name} < /usr/share/zabbix-pgsql/schema.sql"
      } ->
      exec {'init db - images':
        command => "/usr/bin/pgsql -h ${db_host} -u ${db_user} -p ${db_password} ${db_name} < /usr/share/zabbix-pgsql/images.sql"
      } ->
      exec {'init db - data':
        command => "/usr/bin/pgsql -h ${db_host} -u ${db_user} -p ${db_password} ${db_name} < /usr/share/zabbix-pgsql/data.sql"
      }
    }

  }

}
