# it loads automatically entities that are associated with models in your app
Grape::Transformations.setup do |config|
  config.load_entities_from File.join('test_app', 'entities')
end
