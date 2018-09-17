require 'nokogiri'

require 'net/http'
require 'uri'

module OriginalURI
  def self.canonical_amazon_url(url)
    uri = URI.parse url

    require 'open-uri'
    body = open(uri).read

    doc = Nokogiri::HTML.parse(body)
    asin = doc.css('#ASIN').last[:value]
    "https://amazon.jp/dp/#{asin}"
  end
end

