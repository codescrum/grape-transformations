module TestApp
  module Entities
    module Animals
      class Compact < Grape::Entity
        expose :name, documentation: { type: "string", desc: "animal name", example: 'Cow' }
        expose :description, documentation: { type: "string", desc: "animal name", example: 'Are the most common type of large domesticated ungulates. They are a prominent modern member of the subfamily Bovinae' }
      end
    end
  end
end
