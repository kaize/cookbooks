long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "mongodb", "Setup mongodb"
depends "apt"

%w{ ubuntu debian }.each do |os|
  supports os
end
