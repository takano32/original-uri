require "test_helper"

class OriginalizeURITest < Minitest::Test
  require 'uri'
  def test_that_it_has_a_version_number
    refute_nil ::OriginalizeURI::VERSION
  end

  def test_chase_gunosy_uri
    url  = 'https://gunosy.com/articles/RbaP7?s=s'
    ourl = 'https://getnavi.jp/digital/289215/'

    result = OriginalizeURI.chase(URI.parse url)

    assert result, ourl
  end

  def test_it_does_something_useful
    assert true
  end
end
