module TestApp
  module Entities
    module Users
      class Default < Grape::Entity
        expose :name, documentation: { type: "string", desc: "user full name", example: 'Allam Britto' }
        expose :age, documentation: { type: "integer", desc: "user age", example: 24 }
        expose :birthday, documentation: { type: "date", desc: "the project id for the entry", example: 'Tue, 11 Nov 1990' }
        expose :phone, documentation: { type: "string", desc: "phone", example: '555-5555' }
        expose :address, documentation: { type: "string", desc: "address", example: 'Fake St. 12 - 3' }
      end
    end
  end
end
