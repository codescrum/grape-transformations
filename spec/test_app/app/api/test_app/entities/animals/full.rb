module TestApp
  module Entities
    module Animals
      class Full < Grape::Entity
        expose :name, documentation: { type: "string", desc: "animal name", example: 'Cow' }
        expose :description, documentation: { type: "string", desc: "animal name", example: 'Are the most common type of large domesticated ungulates. They are a prominent modern member of the subfamily Bovinae' }
        expose :phylum, documentation: { type: "string", desc: "user age", example: 'Chordata' }
        expose :diet, documentation: { type: "string", desc: "address", example: 'vegetarian' }
      end
    end
  end
end
