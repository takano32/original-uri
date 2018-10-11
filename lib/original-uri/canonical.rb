require 'nokogiri'

require 'net/http'
require 'uri'

module OriginalURI
  def self.canonical_amazon_url(url)

    uri = URI.parse url
    response = Net::HTTP.get_response uri
    while response.code =~ /30[123]/
      url = response['location']
      uri = URI.parse url
      response = Net::HTTP.get_response uri
    end

    body = Net::HTTP.get uri

    doc = Nokogiri::HTML.parse(body)
    asin = nil
    begin
      asin = doc.css('#ASIN').last[:value]
    rescue
      begin
        asin = doc.css("input[name='ASIN']").last[:value]
      rescue
        begin
          asin = doc.css("input[name='ASIN.0']").last[:value]
        rescue
        end
      end
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

