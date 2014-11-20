module Grape
  module Generators
    module Transformations
      class ModuleGenerator < ::Rails::Generators::Base

        desc <<-DESC
          Create inherited Grape::API class in your app/api/.../modules folder. this 
          created class will have related with grape-transformations naming conventions

          For example:

            rails generate module user

          This will create a entity class at app/api/.../entities/users/default.rb like this:

            module TestApp
              module Modules
                class User < Grape::API
                  include Grape::Transformations::Base
                  target_model ::User
                  helpers do
                    # Write your helpers here
                  end
                  define_endpoints do |entity|
                    # Write your single endpoints here
                  end
                  resource :users do
                    add_endpoints
                  end    
                end
              end
            end 
        DESC

        source_root File.expand_path('../../templates', __FILE__)

        argument :module_name, type: :string, required: true, desc: 'name of module'
        argument :raw_target_model, :type => :string, required: false, desc: 'name of target model'
        
        def generate_layout
          @fields ||= []
          template "module.rb", "app/api/#{app_name}/modules/#{underscored_module_name}.rb"
        end

        private

        # Returns the app name
        # @return [String]
        def app_name
          Rails.application.config.session_options[:key].sub(/^_/,'').sub(/_session/,'')
        end

        def underscored_module_name
          module_name.underscore unless module_name.nil?
        end

        def target_model
          raw_target_model.nil? ? underscored_module_name.classify : raw_target_model.classify
        end

      end
    end
  end
end
