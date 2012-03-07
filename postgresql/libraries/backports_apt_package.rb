require 'chef/provider/package/apt'
require 'chef/resource/package'

class Chef

  class Provider
    class Package
      class BackportsApt < Chef::Provider::Package::Apt

        RELEASE_NAME = "squeeze-backports"

        def load_current_resource
          super
          # re-check candidate from backports
          status = popen4("apt-cache -o APT::Default-Release=#{RELEASE_NAME} policy #{@new_resource.package_name}") do |pid, stdin, stdout, stderr|
            stdout.each do |line|
              case line
              when /^\s{2}Candidate: (.+)$/
                Chef::Log.debug("Current version is actually #{$1}")
                @candidate_version = $1
              end
            end
          end
          @new_resource.options("#{@new_resource.options} -t #{RELEASE_NAME}")
        end

        @current_resource
      end
    end
  end

  class Resource
    class BackportsAptPackage < Chef::Resource::Package
      def initialize(name, run_context=nil)
        super
        @resource_name = :backports_apt_package
        @provider = Chef::Provider::Package::BackportsApt
      end
    end
  end

end
