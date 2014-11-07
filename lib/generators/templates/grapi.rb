# it loads automatically entities that are associated with models in your app
Grapi.setup do |config|
  config.load_entities_from File.join('<%= app_name %>', 'entities')
end
