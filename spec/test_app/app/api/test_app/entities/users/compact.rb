module TestApp
  module Entities
    module Users
      class Compact < Grape::Entity
        expose :name, documentation: { type: "string", desc: "user full name", example: 'Allam Britto' }
        expose :phone, documentation: { type: "string", desc: "phone", example: '555-5555' }
      end
    end
  end
end
