require 'test_helper'

class ChkexTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Chkex::VERSION
  end

  def test_check_one_domain
    result = Chkex.run_one('google.com')

    assert result.is_a?(Hash)
  end

  def check_list_of_domains
    result = Chkex.run('test/domains.txt')

    assert result.is_a?(Hash)
  end
end
