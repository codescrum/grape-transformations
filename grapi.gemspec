$:.push File.expand_path("../lib", __FILE__)
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grapi/version'

Gem::Specification.new do |spec|
  spec.name          = "grapi"
  spec.version       = Grapi::VERSION
  spec.authors       = ["Johan Tique", "Miguel Diaz"]
  spec.email         = ["johan.tique@codescrum.com", "miguel.diaz@codescrum.com"]
  spec.summary       = %q{Grapi decouples your entities from your models and also organizes and lets you use multiple entities per model }
  spec.description   = %q{Grapi decouples your entities from your models and also organizes and lets you use multiple entities per model }
  spec.homepage      = "http://www.codescrum.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  #spec.test_files    = spec.files.grep(%r{^(test|spec|features|generators)/})
  spec.test_files    = Dir["spec/**/*"]
  spec.require_paths = ["lib"]

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  spec.add_development_dependency "rails", "~> 4.1.7"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'ammeter'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'virtus'
  spec.add_development_dependency 'railties'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codeclimate-test-reporter', '0.4.0'

  spec.add_runtime_dependency 'grape', '>= 0.7.0', '<= 0.9.0'
  spec.add_runtime_dependency 'grape-entity', '~> 0.4.0'
  
  
end
