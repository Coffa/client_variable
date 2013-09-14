module ClientVariable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Generates a variable config"

      def create_config_file
        template "config.yml", "config/client_variable.yml"
      end
    end
  end
end
