module Grape
  module Generators
    module Transformations
      class EntityGenerator < ::Rails::Generators::Base

        desc <<-DESC
          Create inherited Grape::Entity entity in your app/api/.../entities folder. this 
          created entity will have related with grape-transformations naming conventions

          For example:

            rails generate entity user

          This will create a entity class at app/api/.../entities/users/default.rb like this:

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

        argument :composed_entity_name, type: :string, required: true, desc: 'name of entity'
        argument :fields, :type => :array, required: false, desc: 'field set that you want to expose'
        
        def generate_layout
          @fields ||= []
          template "entity.rb", "app/api/#{app_name}/entities/#{underscored_entity_name.pluralize}/#{class_name.underscore}.rb"
        end

        private

        # Returns the app name
        # @return [String]
        def app_name
          Rails.application.config.session_options[:key].sub(/^_/,'').sub(/_session/,'')
        end

        def class_name
          underscored_transformation_name.nil? ? 'Default' : underscored_transformation_name.classify
        end

        def entity_name
          composed_entity_name.split(':').first
        end

        def transformation_name
          composed_entity_name.split(':').second
        end

        def underscored_entity_name
          entity_name.underscore unless entity_name.nil?
        end

        def underscored_transformation_name
          transformation_name.underscore unless transformation_name.nil? 
        end

      end
    end
  end
end
