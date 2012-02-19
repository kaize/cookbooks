include_recipe "nginx::apt_source"

package 'nginx' do
  options "--force-yes"
end

# runs /etc/init.d/example_service (start|stop|restart), etc.
service "nginx" do
  supports :status => true, :restart => true, :reload => true
  #subscribes :reload, resources(:template => "/etc/nginx/nginx.conf")
  action :enable
end
