# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'three-things/version'

Gem::Specification.new do |spec|
  spec.name          = "three-things"
  spec.version       = ThreeThings::VERSION
  spec.authors       = ["Nat Welch"]
  spec.email         = ["nat@natwelch.com"]

  spec.summary       = %q{A simple statsd middleware for rack.}
  spec.homepage      = "https://github.com/icco/three-things"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.3'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "dogstatsd-ruby", "~> 1.6"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency "rack"
end
