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
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  spec.add_dependency "rails", "~> 4.1.7"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'grape', '0.8.0'
end
