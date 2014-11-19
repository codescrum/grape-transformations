$:.push File.expand_path("../lib", __FILE__)
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape/transformations/version'

Gem::Specification.new do |spec|
  spec.name          = "grape-transformations"
  spec.version       = Grape::Transformations::VERSION
  spec.authors       = ["Johan Tique", "Miguel Diaz"]
  spec.email         = ["johan.tique@codescrum.com", "miguel.diaz@codescrum.com"]
  spec.summary       = %q{grape-transformations decouples your entities from your models and also organizes and lets you use multiple entities per model }
  spec.description   = %q{grape-transformations your entities from your models and also organizes and lets you use multiple entities per model }
  spec.homepage      = "https://github.com/codescrum/grape-transformations"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  #spec.test_files    = spec.files.grep(%r{^(test|spec|features|generators)/})
  spec.test_files    = Dir["spec/**/*"]
  spec.require_paths = ["lib"]

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  spec.add_development_dependency "rails", ">= 4.1.7"
  spec.add_development_dependency "bundler", ">= 1.5"
  spec.add_development_dependency "rake", ">= 10.3.2"
  spec.add_development_dependency 'rspec', ">= 3.1.0"
  spec.add_development_dependency 'ammeter', ">= 1.1.2"
  spec.add_development_dependency 'sqlite3', ">= 1.3.10"
  spec.add_development_dependency 'virtus', ">= 1.0.3"
  spec.add_development_dependency 'railties', ">= 4.1.7"
  spec.add_development_dependency 'rspec-rails', ">= 3.1.0"
  spec.add_development_dependency 'activesupport', ">= 4.1.7"
  spec.add_development_dependency 'pry-byebug', ">= 2.0.0"
  spec.add_development_dependency 'simplecov', ">= 0.8.2"
  spec.add_development_dependency 'rspec-mocks', ">= 3.1.0"
  spec.add_development_dependency 'codeclimate-test-reporter', '0.4.0'

  spec.add_runtime_dependency 'grape', '>= 0.7.0', '<= 0.9.0'
  spec.add_runtime_dependency 'grape-entity', '~> 0.4.0'
  
  
end
