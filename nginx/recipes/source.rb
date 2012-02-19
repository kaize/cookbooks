include_recipe "nginx::apt_source"

package "libgd2-xpm-dev"

execute "apt-get-build-dep" do
  command "apt-get build-dep nginx -y"
  action :run
end

install_from_release("nginx") do
  release_url   node[:nginx][:release_url]
  version       node[:nginx][:version]
  action        [:configure_with_autoconf, :install_with_make]
  autoconf_opts Array(node[:nginx][:autoconf_options]) | node[:nginx][:addition_options]
  not_if{ ::File.exists?("/usr/sbin/nginx") && !node[:nginx][:force_compile]}
end

directory node[:nginx][:log_dir] do
  mode "0755"
end

directory node[:nginx][:cache_dir] do
  mode "0755"
end

cookbook_file "/etc/init.d/nginx" do
  source "init.d.nginx"
  mode "0755"
  owner "root"
end

# runs /etc/init.d/example_service (start|stop|restart), etc.
service "nginx" do
  supports :status => true, :restart => true, :reload => true
  #subscribes :reload, resources(:template => "/etc/nginx/nginx.conf")
  action :enable
end
