#
# Cookbook Name:: postgresql
# Recipe:: client
#

#include_recipe "apt"

package "postgresql-client" do
  provider Chef::Provider::Package::BackportsApt
end

package "postgresql-server-dev-9.1" do
  provider Chef::Provider::Package::BackportsApt
end
