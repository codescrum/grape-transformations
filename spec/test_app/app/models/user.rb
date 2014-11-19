class User
  include Virtus.model

  attribute :name, String
  attribute :age, Integer
  attribute :birthday, DateTime
  attribute :phone, Integer
  attribute :address, String

  def self.all ; end
  def self.find(id = nil) ; end
  
end
