## Database connection
env = (ENV['RACK_ENV'] || :development)
Mongoid.load!('./config/mongoid.yml', env)
