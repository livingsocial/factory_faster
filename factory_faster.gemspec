# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'factory_faster/version'

Gem::Specification.new do |spec|
  spec.name          = "factory_faster"
  spec.version       = FactoryFaster::VERSION
  spec.authors       = ["Tom Copeland"]
  spec.email         = ["tom.copeland@livingsocial.com"]
  spec.summary       = %q{FactoryFaster makes your FactoryGirl tests faster.}
  spec.description   = %q{FactoryFaster makes your FactoryGirl tests faster.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mocha", "~> 0.14.0"
  spec.add_development_dependency "shoulda"
end
