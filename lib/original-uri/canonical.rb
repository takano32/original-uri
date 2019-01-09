require 'nokogiri'

require 'net/http'
require 'uri'

module OriginalURI
  def self.canonical_link(url)
    uri = URI.parse url
    body = Net::HTTP.get uri
    doc = Nokogiri::HTML.parse(body)
    begin
      url = doc.xpath('//link[@rel="canonical"]').first[:href]
    rescue
      url = uri.to_s
    end
    url
  end

  def self.canonical_amazon_url(url)
    uri = URI.parse url
    response = Net::HTTP.get_response uri
    while response.code =~ /30[123]/
      url = response['location']
      uri = URI.parse url
      response = Net::HTTP.get_response uri
    end

    url = canonical_link(url)
    asin = nil
    if url =~ %r!.*/dp/([0-9A-Z]+)$!
      asin = $1
    end
    raise if asin.nil?
    # "https://amazon.jp/dp/#{asin}"
    "https://www.amazon.co.jp/dp/#{asin}"
  end

  def self.canonical_twitter_url(url)
    url = url.sub %r!^(http://)!, 'https://'
    url = url.sub %r!^(https?://)(mobile\.)?(twitter\.com/)!, '\1\3'
    url = url.sub %r!^(https?://twitter.com/.*)\?s=[0-9]+$!, '\1'
    url
  end
end

