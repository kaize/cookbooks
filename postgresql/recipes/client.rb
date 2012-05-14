#
# Cookbook Name:: postgresql
# Recipe:: client
#

#include_recipe "apt"

package "postgresql-client-9.1" do
  provider Chef::Provider::Package::BackportsApt
end

