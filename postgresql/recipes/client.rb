#
# Cookbook Name:: postgresql
# Recipe:: client
#

#include_recipe "apt"

backports_apt_package "postgresql-client-9.1" do
  provider Chef::Provider::Package::BackportsApt
end

