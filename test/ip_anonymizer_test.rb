require_relative "test_helper"

class IpAnonymizerTest < Minitest::Test
  def test_mask_ipv4
    assert_equal "8.8.4.0", IpAnonymizer.mask_ip("8.8.4.4")
  end

  def test_mask_ipv6
    assert_equal "2001:4860:4860::", IpAnonymizer.mask_ip("2001:4860:4860:0:0:0:0:8844")
  end

  def test_hash_ipv4
    assert_equal "6.128.151.207", IpAnonymizer.hash_ip("8.8.4.4", key: "secret")
  end

  def test_hash_ipv6
    assert_equal "f6e4:a4fe:32dc:2f39:3e47:84cc:e85e:865c", IpAnonymizer.hash_ip("2001:4860:4860:0:0:0:0:8844", key: "secret")
  end
end
