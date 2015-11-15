# BuckarooJson

Ruby client for [JSON based Buckaroo checkout gateway](https://checkout.buckaroo.nl/json/Docs).

This gem currently provides authentication for requests to the gateway:

```ruby
BuckarooJson::AuthorizationHeader.create(
  website_key: 'foo',
  api_key: 'bar',
  method: 'GET',
  url: 'https://checkout.buckaroo.nl/json/path/to/endpoint',
  content: '{"some": "JSON string"}' # optional value, leave blank for GET
)
# => 'hmac foo:[[AUTHENTICATION_HASH]]:[[NONCE]]:[TIMESTAMP]]'
```

Use this string as the value for your `Authorization` HTTP header:

    Authorization: hmac foo:...:...:...

That's it!

(Support for specific transaction types is still work in progress.)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'buckaroo_json'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install buckaroo_json

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/buckaroo_json. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

