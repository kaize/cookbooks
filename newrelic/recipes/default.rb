#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

apt_repository "newrelic" do
  uri "http://apt.newrelic.com/debian/"
  distribution "newrelic"
  components ["non-free"]
  #not working key
  #keyserver "hkp://subkeys.pgp.net"
  #key "548C16BF"
  action :add
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

package "newrelic-sysmond" do
  options "--force-yes"
end

service "newrelic-sysmond" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end

template '/etc/newrelic/nrsysmond.cfg' do
  source 'nrsysmond.cfg.erb'
  mode 0755
  owner 'root'
  group 'root'
  notifies :restart, resources(:service => "newrelic-sysmond")
end
