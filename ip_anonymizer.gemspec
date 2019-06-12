require_relative "lib/ip_anonymizer/version"

Gem::Specification.new do |spec|
  spec.name          = "ip_anonymizer"
  spec.version       = IpAnonymizer::VERSION
  spec.summary       = "IP address anonymizer for Ruby and Rails"
  spec.homepage      = "https://github.com/ankane/ip_anonymizer"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@chartkick.com"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.4"

  spec.add_development_dependency "benchmark-ips"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
end
