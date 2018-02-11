## Dependencies
require 'bundler'

Bundler.require :default
Dotenv.load("./.env.#{(ENV['RACK_ENV'] || 'development')}")

## Main application files
require './init.rb'

## CORS
require 'rack/cors'
use Rack::Cors do
	allow do
		origins '*'
		resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete, :patch]
	end
end

run Rack::Cascade.new [BOILERPLATE::API]
