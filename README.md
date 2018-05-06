# IP Anonymizer

:earth_americas: IP address anonymizer for Ruby

Works with IPv4 and IPv6, and includes middleware for Rails

[![Build Status](https://travis-ci.org/ankane/ip_anonymizer.svg?branch=master)](https://travis-ci.org/ankane/ip_anonymizer)

## Getting Started

Add these lines to your application’s Gemfile:

```ruby
gem 'ip_anonymizer'
```

There are two strategies for anonymizing IPs.

### Masking

This is the approach [Google Analytics uses for IP anonymization](https://support.google.com/analytics/answer/2763052):

- For IPv4, the last octet is set to 0
- For IPv6, the last 80 bits are set to zeros

```ruby
IpAnonymizer.mask_ip("8.8.4.4")
# => "8.8.4.0"

IpAnonymizer.mask_ip("2001:4860:4860:0:0:0:0:8844")
# => "2001:4860:4860::"
```

An advantange of this approach is geocoding will still work, only with slightly less accuracy. A disadvantage is different IPs will have the same mask (`8.8.4.4` and `8.8.4.5` both become `8.8.4.0`).

### Hashing

Transform IP addresses with a keyed hash function (PBKDF2-HMAC-SHA256).

```ruby
IpAnonymizer.hash_ip("8.8.4.4", key: "secret")
# => "6.128.151.207"

IpAnonymizer.hash_ip("2001:4860:4860:0:0:0:0:8844", key: "secret")
# => "f6e4:a4fe:32dc:2f39:3e47:84cc:e85e:865c"
```

Be sure to keep the key secret, or else a rainbow table can be constructed.

An advantage of this approach is different IPs will have different hashes.

## Rails

Automatically anonymize `request.remote_ip` in Rails.

For masking, add to `config/application.rb`:

```ruby
config.middleware.insert_after ActionDispatch::RemoteIp, IpAnonymizer::MaskIp
```

For hashing, use:

```ruby
config.middleware.insert_after ActionDispatch::RemoteIp, IpAnonymizer::HashIp, key: "secret"
```

## History

View the [changelog](https://github.com/ankane/ip_anonymizer/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/ip_anonymizer/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/ip_anonymizer/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development and testing:

```sh
git clone https://github.com/ankane/ip_anonymizer.git
cd ip_anonymizer
bundle install
rake test
```
