module TestApp
  module Modules
    class Animal < Grape::API
      include Grapi::Transformations

      target_model ::Animal

      format :json

      content_type :json, 'application/json'

      # Defines all non-transformable entities
      define_non_transformable_endpoints do |entity|
        desc 'returns all existent animals', {
          entity: entity
        }
        get '/foo' do
          content_type "text/json"
          present ::Animal.all
        end

        desc 'returns specific animal', {
          entity: entity
        }
        get '/bar/:id' do
          content_type "text/json"
          animal = ::Animal.find
          present animal, with: TestApp::Entities::Animals::Compact
        end
      end

      version :v1 do
        resource :animals do
          add_endpoints
        end
      end
    end
  end
end
