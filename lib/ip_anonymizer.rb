require "ipaddr"
require "openssl"

require "ip_anonymizer/hash_ip"
require "ip_anonymizer/mask_ip"
require "ip_anonymizer/version"

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

  def self.hash_ip(ip, key:, iterations: 1, insecure_key: false)
    addr = IPAddr.new(ip.to_s)
    key_len = addr.ipv4? ? 4 : 16
    family = addr.ipv4? ? Socket::AF_INET : Socket::AF_INET6

    unless insecure_key
      raise "Key must use binary encoding" if key.encoding != Encoding::BINARY
      raise "Key must be 32 bytes" if key.bytesize != 32
    end

    keyed_hash = OpenSSL::PKCS5.pbkdf2_hmac(addr.to_s, key, iterations, key_len, "sha256")
    IPAddr.new(keyed_hash.bytes.inject { |a, b| (a << 8) + b }, family).to_s
  end
end
