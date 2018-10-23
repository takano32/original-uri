require "test_helper"

class OriginalURITest < Minitest::Test
  require 'uri'
  def test_that_it_has_a_version_number
    refute_nil ::OriginalURI::VERSION
  end

  def test_chase_smartnews_url
    url  = 'https://web.smartnews.com/articles/2Z4euf3qHYJ'
    ourl = 'https://moneyforward.com/media/second-life/66971/'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_line_news_url
    url  = 'https://lin.ee/2Kywgx0' +
      '?utm_source=line&utm_medium=share' +
      '&utm_campaign=none&share_id=CxL40300439197'
    ourl = 'https://www.oricon.co.jp/news/2122027/full/'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_abema_tv_url
    url  = 'https://gxyt4.app.goo.gl/iCPH2'
    ourl = 'https://abema.tv/channels/special-plus/slots/9NKur2EBZuLLmd'
    # https://abema.tv/channels/special-plus/slots/9NKur2EBZuLLmd
    # ?utm_campaign=slot_share_ln&utm_medium=social&utm_source=line

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_47news_url1
    url  = 'https://www.47news.jp/news/2894740.html'
    ourl = 'https://this.kiji.is/426944380327330913'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_47news_url2
    url  = 'https://www.47news.jp/economics/newproduct/2897329.html'
    ourl = 'https://www.ehime-np.co.jp/article/news201810230047'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_gunosy_url1
    url  = 'https://gunosy.com/articles/Rvn80?s=s'
    ourl = 'https://www.gizmodo.jp/2018/08/pix_backpack.html'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_gunosy_url2
    url  = 'https://gunosy.com/articles/RbaP7?s=s'
    ourl = 'https://getnavi.jp/digital/289215/'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_gunosy_url3
    url  = 'https://gunosy.com/articles/Rhl60?s=s'
    ourl = 'http://nlab.itmedia.co.jp/nl/articles/1808/18/news005.html'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_hackadoll_url
    url  = 'https://web.hackadoll.com/n/8naoC'
    ourl = 'http://kanmsu.com/archives/45453'

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

  def test_canonical_twitter_url1
    url =  'http://mobile.twitter.com/Vegeta_Pchan?s=06'
    ourl = 'https://twitter.com/Vegeta_Pchan'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_canonical_twitter_url2
    url =  'http://mobile.twitter.com/Tsukumo_eX/status/1050303051750236160?s=06'
    ourl = 'https://twitter.com/Tsukumo_eX/status/1050303051750236160'

    uri = URI.parse url
    result = uri.original.to_s

    assert_equal result, ourl
  end

  def test_chase_other_url
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
