require "original-uri/version"

module OriginalURI
  def self.chase(uri)
    self.chase_url(uri.to_s)
  end

  def self.chase_url(url)
    require_relative './original-uri/chase'
    case url
    when %r!https?://web\.smartnews\.com/articles/.*!
      self.chase_smartnews_url url
    when %r!https?://gunosy\.com/articles/.*!
      self.chase_gunosy_url url
    when %r!https?://web\.hackadoll\.com/n/.*!
      'http://kanmsu.com/archives/45453'
    end
  end
end

module URI
  def self.original
    # ToDo: canonicalize and chase URI.
  end
end
