# PDFactory::Client

This gem is a convenient Ruby client to interact with PDFactory, the [microservice](https://github.com/dncrht/pdfactory) that generates PDFs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pdfactory-client'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install pdfactory-client
```

## Usage

Ensure you have an up and running PDFactory server. Please refer to [its documentation](https://github.com/dncrht/pdfactory).

Depending how your server is configured, there'll be different ways to use this client. Examples:

```ruby
# Specify URL, user and password to access a protected server
client = PDFactory::Client.new(url: 'http://localhost:5000/', user: 'user', password: 'password')

# Specify URL only, to access an open server
client = PDFactory::Client.new(url: 'http://localhost:5000/')

# Read URL, user and password from ENV vars
ENV['PDFACTORY_URL'] = 'http://localhost:5000/'
ENV['PDFACTORY_USER'] = 'user'
ENV['PDFACTORY_PASSWORD'] = 'password'
client = PDFactory::Client.new

# Override URL, user and/or password (eg: user)
client = PDFactory::Client.new(user: 'l33t')
```

Convert the HTML document:

```ruby
html = '<b>kk</b>'
pdf = client.html2pdf(html)
```

PDF is a binary string that you can stream through your webapp or even save to disk:

```ruby
File.write('my.pdf', pdf)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` or `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dncrht/pdfactory-client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
