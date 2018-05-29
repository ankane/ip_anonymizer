require_relative "test_helper"

class IpAnonymizerTest < Minitest::Test
  def test_mask_ipv4
    assert_equal "8.8.4.0", IpAnonymizer.mask_ip("8.8.4.4")
  end

  def test_mask_ipv6
    assert_equal "2001:4860:4860::", IpAnonymizer.mask_ip("2001:4860:4860:0:0:0:0:8844")
  end

  def test_hash_ipv4
    assert_equal "193.3.10.88", IpAnonymizer.hash_ip("8.8.4.4", key: secret_key)
  end

  def test_hash_ipv6
    assert_equal "dfd0:2934:a76:b607:fc7f:fd8d:a916:ed63", IpAnonymizer.hash_ip("2001:4860:4860:0:0:0:0:8844", key: secret_key)
  end

  def test_ipaddr_object
    assert_equal "8.8.4.0", IpAnonymizer.mask_ip(IPAddr.new("8.8.4.4"))
  end

  private

  def secret_key
    ["0"*64].pack("H*")
  end
end
