Facter.add("zabbix_proxy_version") do
  setcode do
      distid = Facter.value('lsbdistid')
      case distid
      when /RedHatEnterprise|CentOS|Fedora/
          Facter::Util::Resolution.exec('/bin/rpm -q --qf "%{VERSION} zabbix-proxy')
      when "ubuntu"
          Facter::Util::Resolution.exec('/bin/dpkg-query -W -f \'${version}\n\' zabbix-proxy-sqlite3 | cut -d":" -f2')
          "debian"
      else
          distid
      end

   
# rpm -q --qf "%{VERSION} zabbix-proxy


  end
end
