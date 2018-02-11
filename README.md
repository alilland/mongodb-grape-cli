# Grape::Cli::Mongodb

Quickly bootstrap a working Grape API with MongoDB (you must have MongoDB installed, and have it running on localhost with the default port)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grape-cli-mongodb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install grape-cli-mongodb

## Usage

Quickly start a boilerplate Grape API with a MongoDB backend using the following command:

    $ grape -n YOUR_PROJECT_NAME

Next, cd into your directory

    $ cd YOUR_PROJECT_NAME

Install the project dependencies/generate a new Gemfile.lock

    $ bundle install

Lastly, run the project - if everything works correctly the puma server should start your server

    $ bundle exec rackup


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aronlmin/grape-cli-mongodb.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
