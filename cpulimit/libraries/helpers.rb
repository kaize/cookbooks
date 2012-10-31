module CPULimit
	module Helpers
		#Returns an array of package names that will install cpulimit on a node.
		#Package names returned are determined by the platform running this recipe.
		def cpulimit_packages
			value_for_platform(
				[ "ubuntu" ] => { "default" => [ "cpulimit" ] },
				"default" => [ "cpulimit" ]
			)
		end
	end
end

class Chef::Recipe
	include CPULimit::Helpers
end
