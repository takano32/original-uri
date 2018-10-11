require "original-uri/version"

require 'uri'

module OriginalURI
  def self.chase(uri)
    begin
      URI.parse self.chase_url(uri.to_s)
    rescue
      uri
    end
  end

  def self.canonical(uri)
    begin
      URI.parse self.canonical_url(uri.to_s)
    rescue
      uri
    end
  end

  def self.canonical_url(url)
    require_relative './original-uri/canonical'
    case url
    when %r!https?://(www\.)?amazon(\.co)?\.jp/.*!
      self.canonical_amazon_url url
    when %r!https?://(mobile\.)?twitter\.com/([0-9A-Za-z_]{1,15})/?.*!
      self.canonical_twitter_url url
    else
      url
    end
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
    uri = self
    uri = OriginalURI.chase(uri)
    uri = OriginalURI.canonical(uri)
  end
end
