module TestApp
  module Entities
    class Food < Grape::Entity
      expose :name, documentation: { type: "string", desc: "food name", example: 'Mondongo' }
      expose :description, documentation: { type: "string", desc: "food description", example: 'is a soup made from diced tripe (the stomach of a cow) slow-cooked with vegetables such as bell peppers, onions, carrots, cabbage, celery, tomatoes, cilantro (coriander), garlic or root vegetables.' }
    end
  end
end
