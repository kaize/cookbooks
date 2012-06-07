package 'exim4'

template "/etc/exim4/update-exim4.conf.conf" do
  source "update-exim4-conf.conf.erb"
  variables({
    :hostname => node['fqdn']
  })
end

execute "update-exim4.conf"

service "exim4" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end
