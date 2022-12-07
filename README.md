# Screenshot API Ruby Gem
This is a simple wrapper to interact with the ScreenshotOne API with Ruby.
It's based on the [API guide](https://screenshotone.com/docs/getting-started/)

## Usage
Add this gem to your Gemfile:
```rb
gem 'screenshot_one_api'
```

Then you need to initialize a Client with your `access_key` and an optional `secret_key`
(in case you want sign all the request for publicly sharing the urls).

```rb
client = ScreenshotOneApi::Client.new('dailytics.com', '123123')
```

Now you need to define the options of the screenshot
```rb
# You can set any available option, in a camel_case format
options = ScreenshotOneApi::TakeOptions.new(url: 'https://example.com').
            full_page(true).
            delay(2).
            geolocation_latitude(48.857648).
            geolocation_longitude(2.294677).
            geolocation_accuracy(50)

# Verify all the parameters are valid
options.valid?
=> true
```

And finally:
```rb
# To simply get the final url:
client.generate_take_url(options)
=> "https://api.screenshotone.com/take?url=https%3A%2F%2Fexample.com..."

# To actually get the image (pending method)
client.take(options)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/luctus/screenshot_one_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/luctus/screenshot_one_api/blob/main/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PlausibleApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/luctus/screenshot_one_api/blob/main/CODE_OF_CONDUCT.md).
