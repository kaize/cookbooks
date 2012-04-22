#
# Cookbook Name:: postgresql
# Recipe:: server
#

include_recipe "postgresql::client"

package "postgresql-9.1" do
  provider Chef::Provider::Package::BackportsApt
end

package "postgresql-server-dev-9.1" do
  provider Chef::Provider::Package::BackportsApt
end

#TODO create databases and users

service "postgresql" do
  supports :restart => true, :status => true, :reload => true
  action :nothing
end
