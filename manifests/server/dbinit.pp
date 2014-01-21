# == Class: zabbix::server::dbinit
#
# RedHat family only!
#
class zabbix::server::dbinit (
) {

  $db_type = $zabbix::server::db_type
  $db_host = $zabbix::server::db_host
  $db_name = $zabbix::server::db_name
  $db_user = $zabbix::server::db_user
  $db_password = $zabbix::server::db_password

  case $db_type {

    default,'mysql': {
      # /usr/share/doc/zabbix-server-mysql-2.2.1/create/schema.sql
      exec {'init db - schema':
        provider => shell,
        #command => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} < /usr/share/doc/zabbix-server-mysql*/create/schema.sql",
        #command  => "/bin/find /usr/share/doc/ -path '*zabbix-server*/create/schema.sql' -exec /usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} < {} \;",
        #command => "/bin/find /usr/share/doc/ -path '*zabbix-server*/create/schema.sql' -exec /usr/bin/sed -e 's/ , );/1,1);/g' {} ; | /usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name}",
        # very nasty hack, because commands above don't work
        command  => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} < `/bin/rpm -ql zabbix-server-mysql | grep 'create/schema.sql'`",
        unless   => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} -e 'DESCRIBE maintenances'",
      } ->
      exec {'init db - images':
        provider => shell,
        #command => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} < /usr/share/doc/zabbix-server-mysql*/create/images.sql",
        #command  => "/bin/find /usr/share/doc/ -path '*zabbix-server*/create/images.sql' -exec /usr/bin/sed -e 's/ , );/1,1);/g' {} ; | /usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name}",
        # very nasty hack, because commands above don't work
        command  => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} < `/bin/rpm -ql zabbix-server-mysql | grep 'create/images.sql'`",
        unless  => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} -e 'SELECT name FROM images' | grep -q Cloud",
      } ->
      exec {'init db - data':
        provider => shell,
        #command => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} < /usr/share/doc/zabbix-server-mysql*/create/data.sql",
        #command  => "/bin/find /usr/share/doc/ -path '*zabbix-server*/create/data.sql' -exec /usr/bin/sed -e 's/ , );/1,1);/g' {} ; | /usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name}",
        # very nasty hack, because commands above don't work
        command => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} < `/bin/rpm -ql zabbix-server-mysql | grep 'create/data.sql'`",
        unless  => "/usr/bin/mysql -h ${db_host} -u ${db_user} -p${db_password} ${db_name} -e 'SELECT name FROM hosts;' | grep -q Template",
      }
    }

    # TODO
    'pgsql': {
      exec {'init db - schema':
        #/usr/share/doc/zabbix-server-pgsql-2.2.1/create/schema.sql
        command => "/usr/bin/pgsql -h ${db_host} -w ${db_password} -d ${db_name} -U ${db_user} -f /usr/share/zabbix-pgsql/schema.sql",
        #unless  => ""
      } ->
      exec {'init db - images':
        #/usr/share/doc/zabbix-server-pgsql-2.2.1/create/images.sql
        command => "/usr/bin/pgsql -h ${db_host} -w ${db_password} -d ${db_name} -U ${db_user} -f /usr/share/zabbix-pgsql/images.sql",
        #unless  => "",
      } ->
      exec {'init db - data':
      #/usr/share/doc/zabbix-server-pgsql-2.2.1/create/data.sql
        command => "/usr/bin/pgsql -h ${db_host} -w ${db_password} -d ${db_name} -U ${db_user} -f /usr/share/zabbix-pgsql/data.sql",
        #unless  => "",
      }
    }

  }

}
