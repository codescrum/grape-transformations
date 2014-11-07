require 'rails/generators/base'

module Grapi
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path("../../templates", __FILE__)

      def copy_initializer
        template "grapi.rb", "config/initializers/grapi.rb"
      end
      
    end
  end
end
