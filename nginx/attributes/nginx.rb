default.nginx[:force_compile] = false
default.nginx[:version] = '1.0.12'
default.nginx[:log_dir] = '/var/log/nginx'
default.nginx[:cache_dir] = '/var/cache/nginx'
default.nginx[:addition_options] = ['--prefix=/etc/nginx/', '--sbin-path=/usr/sbin/nginx', '--conf-path=/etc/nginx/nginx.conf',
                                    "--error-log-path=#{node[:nginx][:log_dir]}/error.log", "--http-log-path=#{node[:nginx][:log_dir]}/access.log",
                                    '--pid-path=/var/run/nginx.pid', '--lock-path=/var/run/nginx.lock', "--http-client-body-temp-path=#{node[:nginx][:cache_dir]}/client_temp",
                                    "--http-proxy-temp-path=#{node[:nginx][:cache_dir]}/proxy_temp", "--http-fastcgi-temp-path=#{node[:nginx][:cache_dir]}/fastcgi_temp",
                                    "--http-uwsgi-temp-path=#{node[:nginx][:cache_dir]}/uwsgi_temp", "--http-scgi-temp-path=#{node[:nginx][:cache_dir]}/scgi_temp", '--user=nginx',
                                    '--group=nginx', '--with-http_ssl_module', '--with-http_realip_module', '--with-http_addition_module', '--with-http_sub_module',
                                    '--with-http_dav_module', '--with-http_flv_module', '--with-http_mp4_module', '--with-http_gzip_static_module',
                                    '--with-http_random_index_module', '--with-http_secure_link_module', '--with-http_stub_status_module', '--with-mail',
                                    '--with-mail_ssl_module', '--with-file-aio', '--with-ipv6']
default.nginx[:autoconf_options] = nil
default.nginx[:release_url] = "http://nginx.org/download/nginx-:version:.tar.gz"
