require 'rails/generators/base'

module Grapi
  module Generators
    class EntityGenerator < Rails::Generators::Base

      desc <<-DESC.strip_heredoc
        Create inherited Grape::Entity entity in your app/api/.../entities folder. this 
        created entity will have related with Grapi naming conventions

        For example:

          rails generate entity user

        This will create a entity class at app/api/.../sessions_controller.rb like this:

          module TestApp
            module Entities
              module Users
                class Default < Grape::Entity
                  
                end
              end
            end
          end 
      DESC

      source_root File.expand_path('../../templates', __FILE__)

      argument :entity_name, type: :string, required: true, desc: 'name of entity'
      argument :fields, :type => :array, required: false, desc: 'field set that you want to expose'
      
      def generate_layout
        @fields ||= []
        template "entity.rb", "app/api/#{app_name}/entities/#{underscored_entity_name.pluralize}/default.rb"
      end

      private

      # Returns the app name
      # @return [String]
      def app_name
        Rails.application.config.session_options[:key].sub(/^_/,'').sub(/_session/,'')
      end

      def underscored_entity_name
        entity_name.underscore
      end

    end
  end
end
