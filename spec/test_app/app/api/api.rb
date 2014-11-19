class API < Grape::API
  prefix 'api'
  # Separate the api into smaller
  # modules like this
  mount TestApp::Modules::User
  mount TestApp::Modules::Animal
end
