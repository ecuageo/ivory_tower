# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ivory_tower/version'

Gem::Specification.new do |spec|
  spec.name          = "ivory_tower"
  spec.version       = IvoryTower::VERSION
  spec.authors       = ["ecuageo", "padwasabimasala"]
  spec.email         = ["ecuageo@gmail.com"]
  spec.description   = %q{Easy abstraction for working with rabbitmq}
  spec.summary       = %q{rabbitmq abstractions}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  
  spec.add_dependency "bunny"
end
