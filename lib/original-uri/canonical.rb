require 'nokogiri'

require 'net/http'
require 'uri'

module OriginalURI
  def self.canonical_amazon_url(url)
    uri = URI.parse url

    require 'open-uri'
    body = open(uri).read

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
end

