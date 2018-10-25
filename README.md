# Chkex

A really simple gem to check domain expiration dates.  One of the tools in our arsenal @starburstcreative.

## Installation

Install the binary:

    $ gem install chkex

## Usage

Process a list of domains:

    $ chkex /path/to/a/file.txt

Get info for a single domain:

    $ chkex google.com

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aapis/chkex.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
