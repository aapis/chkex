require 'test_helper'

class ChkexTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Chkex::VERSION
  end

  def test_check_one_domain
    result = Chkex.run_one('google.com')

    assert result
  end

  def check_list_of_domains
    result = Chkex.run('domains.txt')

    assert result
  end
end
