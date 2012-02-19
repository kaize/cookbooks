long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.3"
recipe            "nginx", "Setup nginx"
depends "apt"
depends "install_from"

%w{ ubuntu debian }.each do |os|
  supports os
end
