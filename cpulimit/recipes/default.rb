case node[:cpulimit][:install_method]
	when :source
		include_recipe "cpulimit::source"
	when :package
		include_recipe "cpulimit::package"
end
