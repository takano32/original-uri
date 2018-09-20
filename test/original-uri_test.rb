require "test_helper"

class OriginalURITest < Minitest::Test
  require 'uri'
  def test_that_it_has_a_version_number
    refute_nil ::OriginalURI::VERSION
  end

  def test_chase_smartnews_uri
    url  = 'https://web.smartnews.com/articles/2Z4euf3qHYJ'
    ourl = 'https://moneyforward.com/media/second-life/66971/'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_gunosy_uri1
    url  = 'https://gunosy.com/articles/Rvn80?s=s'
    ourl = 'https://www.gizmodo.jp/2018/08/pix_backpack.html'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_gunosy_uri2
    url  = 'https://gunosy.com/articles/RbaP7?s=s'
    ourl = 'https://getnavi.jp/digital/289215/'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_gunosy_uri3
    url  = 'https://gunosy.com/articles/Rhl60?s=s'
    ourl = 'http://nlab.itmedia.co.jp/nl/articles/1808/18/news005.html'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_hackadoll_uri
    url  = 'https://web.hackadoll.com/n/8naoC'
    ourl = 'http://kanmsu.com/archives/45453'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_moguravr_uri
    url  = 'https://www.moguravr.com/art-immersion-technology/'
    ourl = 'https://prtimes.jp/main/html/rd/p/000000095.000011115.html'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_canonical_amazon_asin1
    url = 'https://www.amazon.co.jp/Anker-PowerPort-' +
      '%E3%82%BD%E3%83%BC%E3%83%A9%E3%83%BC%E3%83' +
      '%81%E3%83%A3%E3%83%BC%E3%82%B8%E3%83%A3%E3%83%BC-' +
      'Android%E5%90%84%E7%A8%AE%E4%BB%96%E5%AF%BE%E5%BF%9C-%E3%80%90' +
      'PowerIQ%E6%90%AD%E8%BC%89%E3%80%91/dp/B012VOBXU8?psc=1'
    ourl = 'https://www.amazon.co.jp/dp/B012VOBXU8'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_canonical_amazon_asin2
    url = 'https://www.amazon.co.jp/gp/product/B00UYABOQA' +
      '?ref_=dbs_mng_calw_0&storeType=ebooks'
    ourl = 'https://www.amazon.co.jp/dp/B00UYABOQA'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_other_uri
    url  = 'https://www.example.com/'
    ourl = 'https://www.example.com/'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_it_does_something_useful
    assert true
  end
end
