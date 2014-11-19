module Grape
  module Generators
    module Transformations
      class InstallGenerator < ::Rails::Generators::Base

        source_root File.expand_path("../../templates", __FILE__)

        def copy_initializer
          template "grape-transformations.rb", "config/initializers/grape-transformations.rb"
        end

        def generate_layout
          create_file "app/api/#{app_name}/entities/.keep"
        end

        private

        # Returns the app name
        # @return [String]
        def app_name
          Rails.application.config.session_options[:key].sub(/^_/,'').sub(/_session/,'')
        end

      end
    end
  end
end
