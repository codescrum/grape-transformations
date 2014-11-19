class Animal
  include Virtus.model

  attribute :name, String
  attribute :description, String
  attribute :phylum, String
  attribute :diet, String

  def self.all ; end
  def self.find(id = nil) ; end
  
end
