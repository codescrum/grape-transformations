module TestApp
  module Modules
    class User < Grape::API
      include Grape::Transformations::Base

      target_model ::User

      format :json

      content_type :json, 'application/json'

      # Defines all transformable entities
      define_endpoints do |entity|
        desc 'returns all existent users', {
          entity: entity
        }
        get '/' do
          content_type "text/json"
          present ::User.all, with: entity
        end

        desc 'returns specific users', {
          entity: entity
        }
        get '/:id' do
          content_type "text/json"
          user = ::User.find
          present user, with: entity
        end
      end

      version :v1 do
        resource :users do
          add_endpoints
        end
      end
    end
  end
end
