cpulimit_packages.each do |pkg|
	package pkg do
		action :upgrade
	end
end
