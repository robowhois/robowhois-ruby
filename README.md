# RoboWhois - Ruby Client

This is the official Ruby client for [RoboWhois](https://www.robowhois.com/) [API](https://www.robowhois.com/docs/api/).

[RoboWhois](https://www.robowhois.com/) is a web service that provides an API suite to **access WHOIS records and domain related information with a unified, consistent interface**.

Using RoboWhois API you can:

- check domain availability for any supported TLD
- lookup WHOIS information for a domain and retrieve the WHOIS record
- access WHOIS data using a consistent, well-structured, HTTP-based interface
- retrieve WHOIS details parsed as convenient JSON structure

Visit RoboWhois [site](https://www.robowhois.com/) and [documentation](https://www.robowhois.com/docs/) to learn more about the service.


## Installation

The best way to install this library is via [RubyGems](https://rubygems.org/).

    $ gem install robowhois

You might need administrator privileges on your system to install the gem.


## Usage

All the examples below assume you installed the gem and required it via RubyGems.
You also need a [RoboWhois](https://www.robowhois.com/) account and a valid API key.

    require 'robowhois'

Please refer to the RoboWhois [API Documentation](https://www.robowhois.com/docs/api/) for the list of all available API methods and response attributes.

### Account information

```ruby
client = RoboWhois.new(:api_key => 'YOUR_API_KEY')
account = client.account

puts account['email']
# => your email
puts account['credits_limit']
# => available credits
```

### Original WHOIS record

```ruby
client = RoboWhois.new(:api_key => 'YOUR_API_KEY')
response = client.whois('example.com')

puts response
# => The record String
```

### Parsed WHOIS record

```ruby
client = RoboWhois.new(:api_key => 'YOUR_API_KEY')
response = client.whois_properties('example.com')

# The record date
puts response['daystamp']

# The record registrant
if contact = response['properties']['registrant_contacts']
  puts contact['id']
  puts contact['name']
  puts contact['organization']
else
  puts "Registrant details not available."
end

# The record nameservers
response['properties']['nameservers'].each do |nameserver|
  puts nameserver['name']
  puts nameserver['ipv4']
  puts nameserver['ipv6']
end
```

### Response Object

You can access the last response object using the `last_response` method.

```ruby
client = RoboWhois.new(:api_key => 'YOUR_API_KEY')
account = client.account

response = client.last_response
response.code
# => 200
response.headers
# => { ... }
```

### Errors

In case of failure, the API call raises a `RoboWhois::APIError` exception.

```ruby
client = RoboWhois.new(:api_key => 'YOUR_API_KEY')

begin
  response = client.whois_properties('example.es')
rescue => error
  puts error.code
  # => "R04"
  puts error.name
  # => "WhoisServerOnlyWeb"
  puts error.status
  # => 400
end
```

Error codes are explained in the [API Errors](https://www.robowhois.com/docs/api/v1/errors/) documentation page.


## Changelog

See the CHANGELOG.md file for details.


## License

Copyright (c) 2012 RoboDomain Inc.
Copyright (c) 2012-2013 Aetrion LLC.

This is Free Software distributed under the MIT license.
