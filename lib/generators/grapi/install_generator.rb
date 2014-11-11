require 'rails/generators/base'

module Grapi
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path("../../templates", __FILE__)

      def app_name
        Rails.application.config.session_options[:key].sub(/^_/,'').sub(/_session/,'')
      end

      def copy_initializer
        template "grapi.rb", "config/initializers/grapi.rb"
      end

      def generate_layout
        create_file "app/api/#{app_name}/entities/.keep"
      end

    end
  end
end
