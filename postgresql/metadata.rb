version           "0.0.2"

depends           "apt"

%w{ debian }.each do |os|
  supports os
end

