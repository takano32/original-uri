require "originalize-uri/version"

module OriginalizeURI
  def self.chase(uri)
    case uri.to_s
    when %r!https?://web\.smartnews\.com/articles/.*!
      'https://moneyforward.com/media/second-life/66971/'
    when %r!https?://gunosy\.com/articles/.*!
      'https://getnavi.jp/digital/289215/'
    when %r!https?://web\.hackadoll\.com/n/.*!
      'http://kanmsu.com/archives/45453'
    end
  end
end

module URI
  def self.originalize
    # ToDo: canonicalize and chase URI.
  end
end
