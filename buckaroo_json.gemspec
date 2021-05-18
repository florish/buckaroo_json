# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buckaroo_json/version'

Gem::Specification.new do |spec|
  spec.name          = 'buckaroo_json'
  spec.version       = BuckarooJson::VERSION
  spec.authors       = ['Floris Huetink']
  spec.email         = ['florishuetink@gmail.com']

  spec.summary       = 'Ruby client for Buckaroo JSON checkout gateway'
  spec.homepage      = 'https://github.com/florish/buckaroo_json'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end
