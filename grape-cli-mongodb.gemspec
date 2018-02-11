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
  spec.add_development_dependency "rake", ">= 10.0"

  spec.add_dependency 'rack', "~> 2.0.3"
  spec.add_dependency 'rack-cors', "~> 1.0.2"
  spec.add_dependency 'rack-contrib', "~> 1.2.0"
  spec.add_dependency 'dotenv', "~> 2.2.1"
  spec.add_dependency 'grape', "~> 1.0.1"
  spec.add_dependency 'grape-entity', "~> 0.6.1"
  spec.add_dependency 'grape_logging', "~> 1.7.0"
  spec.add_dependency 'puma', "~> 3.10.0"
  spec.add_dependency 'mongoid', "~> 6.2.1"
  spec.add_dependency 'sanitize', "~> 4.5.0"
  spec.add_dependency 'kaminari', "~>0.16.3"
  spec.add_dependency 'pry', "~> 0.11.3"
  spec.add_dependency 'tux', "~> 0.3.0"
end
