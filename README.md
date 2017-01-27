# ThreeThings

ThreeThings is a middleware for monitoring the classic three things web apis want to know about:

 - request rate
 - request duration
 - request error rate

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'three-things'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install three-things

## Usage

```
def statsd
  Statsd.new("localhost", 8125).tap { |sd| sd.namespace = "app.prefix" }
end

class App < Sinatra::Base
  use ThreeThings::Middleware, statsd
  
  get '/' do
    "ok"
  end
end
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/icco/three-things. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/icco/three-things/blob/master/CODE_OF_CONDUCT.md).
