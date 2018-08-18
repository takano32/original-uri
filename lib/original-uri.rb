require "original-uri/version"

require 'uri'

module OriginalURI
  def self.chase(uri)
    URI.parse self.chase_url(uri.to_s)
  end

  def self.chase_url(url)
    require_relative './original-uri/chase'
    case url
    when %r!https?://web\.smartnews\.com/articles/.*!
      self.chase_smartnews_url url
    when %r!https?://gunosy\.com/articles/.*!
      self.chase_gunosy_url url
    when %r!https?://web\.hackadoll\.com/n/.*!
      self.chase_hackadoll_url url
    else
      url
    end
  end
end

module URI
  def original
    uri = OriginalURI.chase(self)
  end
end
