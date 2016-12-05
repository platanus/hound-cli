# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hound/version'

Gem::Specification.new do |spec|
  spec.name          = "hound-cli"
  spec.version       = Hound::VERSION
  spec.authors       = ["Platanus"]
  spec.email         = ["rubygems@platan.us"]

  spec.summary       = "Ruby CLI to generate style rules"
  spec.description   = "Ruby CLI to generate style rules for several linters"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "colorize", "~> 0.7", ">= 0.7.7"
  spec.add_dependency "rest-client", "~> 1.8", ">= 1.8.0"
  spec.add_dependency "commander", "~> 4.4", ">= 4.4.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "pry"
end
