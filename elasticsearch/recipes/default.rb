#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'openjdk-6-jre-headless'

install_from_release(:elasticsearch) do
  release_url   node[:elasticsearch][:release_url]
  home_dir      node[:elasticsearch][:home_dir]
  version       node[:elasticsearch][:version]
  action        [ :install ]
  has_binaries  [ 'bin/elasticsearch' ]
  not_if{ ::File.exists?("#{node[:elasticsearch][:home_dir]}/bin/elasticsearch") && !node[:elasticsearch][:force_compile]}
end

runit_service "elasticsearch" do
  options node[:elasticsearch]
end

if node[:elasticsearch][:init_d]
  template '/etc/init.d/elasticsearch' do
    source 'elasticsearch.init.erb'
    mode 0755
    owner 'root'
    group 'root'
  end
end

directory node[:elasticsearch][:conf_dir] do
  mode "0755"
end

template "#{node[:elasticsearch][:conf_dir]}/elasticsearch.yml" do
  owner  "root"
  group  "root"
  source "elasticsearch.conf.erb"
end
