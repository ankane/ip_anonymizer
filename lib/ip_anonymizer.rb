# stdlib
require "ipaddr"
require "openssl"

# modules
require_relative "ip_anonymizer/hash_ip"
require_relative "ip_anonymizer/mask_ip"
require_relative "ip_anonymizer/version"

module IpAnonymizer
  def self.mask_ip(ip)
    addr = IPAddr.new(ip.to_s)
    if addr.ipv4?
      # set last octet to 0
      addr.mask(24).to_s
    else
      # set last 80 bits to zeros
      addr.mask(48).to_s
    end
  end

  def self.hash_ip(ip, key:, iterations: 1)
    addr = IPAddr.new(ip.to_s)
    key_len = addr.ipv4? ? 4 : 16
    family = addr.ipv4? ? Socket::AF_INET : Socket::AF_INET6

    keyed_hash = OpenSSL::KDF.pbkdf2_hmac(addr.to_s, salt: key, iterations: iterations, length: key_len, hash: "sha256")
    IPAddr.new(keyed_hash.bytes.inject { |a, b| (a << 8) + b }, family).to_s
  end
end
