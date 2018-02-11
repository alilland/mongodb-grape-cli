# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape/cli/mongodb/version'

Gem::Specification.new do |spec|
  spec.name          = "grape-cli-mongodb"
  spec.version       = Grape::Cli::Mongodb::VERSION
  spec.authors       = ["ADL"]
  spec.email         = ["aronlmin@gmail.com"]

  spec.summary       = %q{Quickly bootstrap a grape project with mongodb from the command line}
  spec.description   = %q{Grape cli for a mongodb grape api}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.4.1'
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency 'rack'
  spec.add_runtime_dependency 'rack-cors'
  spec.add_runtime_dependency 'rack-contrib'
  spec.add_runtime_dependency 'dotenv'
  spec.add_runtime_dependency 'grape'
  spec.add_runtime_dependency 'grape-entity'
  spec.add_runtime_dependency 'grape_logging'
  spec.add_runtime_dependency 'puma'
  spec.add_runtime_dependency 'mongoid'
  spec.add_runtime_dependency 'sanitize'
  spec.add_runtime_dependency 'kaminari', "~>0.16.3"
  spec.add_runtime_dependency 'pry'
  spec.add_runtime_dependency 'tux'
end
