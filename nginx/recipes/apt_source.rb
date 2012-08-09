include_recipe "apt"

keyserver = node['nginx'] && node['nginx']['keyserver'] ? node['nginx']['keyserver'] : "keys.gnupg.net"

apt_repository "nginx" do
  uri "http://nginx.org/packages/debian/"
  distribution "squeeze"
  components ["nginx"]
  keyserver keyserver
  key "7BD9BF62"
  action :add
end

apt_repository "nginx-src" do
  deb_src true
  uri "http://nginx.org/packages/debian/"
  distribution "squeeze"
  components ["nginx"]
  keyserver keyserver
  key "7BD9BF62"
  action :add
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end
