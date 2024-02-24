# Hudu API
[![Version](https://img.shields.io/gem/v/homewizard.svg)](https://rubygems.org/gems/homewizard)

This is a wrapper for the HomeWizard rest API.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'homewizard'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install homewizard

## Usage

Before you start making the requests to API provide the endpoint using the configuration wrapping.

```ruby
require 'homewizard'
require 'logger'

# use do block
HomeWizard.configure do |config|
  config.endpoint = ENV['HOMEWIZARD_P1_API_HOST'].downcase
end

# or configure with options hash
client = HomeWizard.client({ logger: Logger.new('debug.log) })

# check api version
return unless if client.device_info.api_version.eql? 'v1'

# get last data
data = client.recent_data

if data.active_power_w < 0
  # do something to use energy

end
```

## Resources
Endpoint for data related requests

|Resource|API endpoint|
|:--|:--|
|.recent_data                      | /api/v1/data|
|.socket_state                     | /api/v1/state|
|.telegram                         | /api/v1/telegram|
|.identify                         | /api/v1/identify|

## Publishing

1. Update version in [version.rb](lib/homewizard/version.rb).
2. Add release to [CHANGELOG.md](CHANGELOG.md)
3. Commit.
4. Test build.
```
> rake build

```
5. Release
```
> rake release

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jancotanis/homewizard.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
