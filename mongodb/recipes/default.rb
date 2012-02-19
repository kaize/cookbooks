apt_repository "mongodb" do
  uri "http://downloads-distro.mongodb.org/repo/debian-sysvinit"
  distribution "dist"
  components ["10gen"]
  keyserver "keyserver.ubuntu.com"
  key "7F0CEB10"
  action :add
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

package 'mongodb-10gen' do
  options "--force-yes"
end

# runs /etc/init.d/example_service (start|stop|restart), etc.
service "mongodb" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end
