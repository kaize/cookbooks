include_recipe "build-essential"
include_recipe "git"

cpulimit_packages.each do |pkg|
	package pkg do
		action :purge
	end
end

creates_cpulimit = "#{node[:cpulimit][:prefix]}/bin/cpulimit"

git "#{Chef::Config[:file_cache_path]}/cpulimit" do
	repository node[:cpulimit][:git_repository]
	reference node[:cpulimit][:git_revision]
	action :sync
  notifies :run, "bash[compile_cpulimit]"
end

bash "compile_cpulimit" do
	cwd "#{Chef::Config[:file_cache_path]}/cpulimit"
	code <<-EOH
    make && cp src/cpulimit #{creates_cpulimit}
	EOH
	creates "#{creates_cpulimit}"
end
