require "test_helper"

class OriginalURITest < Minitest::Test
  require 'uri'
  def test_that_it_has_a_version_number
    refute_nil ::OriginalURI::VERSION
  end

  def test_chase_smartnews_uri
    url  = 'https://web.smartnews.com/articles/2Z4euf3qHYJ'
    ourl = 'https://moneyforward.com/media/second-life/66971/'

    result = OriginalURI.chase(URI.parse url)

    assert result, ourl
  end

  def test_chase_gunosy_uri
    url  = 'https://gunosy.com/articles/RbaP7?s=s'
    ourl = 'https://getnavi.jp/digital/289215/'

    result = OriginalURI.chase(URI.parse url)

    assert result, ourl
  end

  def test_chase_hackadoll_uri
    url  = 'https://web.hackadoll.com/n/8naoC'
    ourl = 'http://kanmsu.com/archives/45453'

    result = OriginalURI.chase(URI.parse url)

    assert result, ourl
  end

  def test_it_does_something_useful
    assert true
  end
end
