require 'nokogiri'

require 'net/http'
require 'uri'

module OriginalURI
  def self.chase_smartnews_url(url)
    body = Net::HTTP.get(URI.parse url)
    doc = Nokogiri::HTML.parse(body)
    doc.xpath("//section[@class='original-link']/a").first[:href]
  end

  def self.chase_gunosy_url(url)
    body = Net::HTTP.get(URI.parse url)
    doc = Nokogiri::HTML.parse(body)
    doc.xpath("//div[@class='article_cushion_link gtm-click']/a").first[:href]
  end
  
end

