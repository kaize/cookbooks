include_recipe "apt"

apt_repository "nginx" do
  uri "http://nginx.org/packages/debian/"
  distribution "squeeze"
  components ["nginx"]
  keyserver "keys.gnupg.net"
  key "7BD9BF62"
  action :add
end

apt_repository "nginx-src" do
  deb_src true
  uri "http://nginx.org/packages/debian/"
  distribution "squeeze"
  components ["nginx"]
  keyserver "keys.gnupg.net"
  key "7BD9BF62"
  action :add
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end
