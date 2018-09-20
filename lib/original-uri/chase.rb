require 'nokogiri'

require 'net/http'
require 'uri'

module OriginalURI
  def self.chase_smartnews_url(url)
    uri = URI.parse url
    # 301
    response = Net::HTTP.get_response uri
    if response.code == '301'
      return response['location']
    end

    body = Net::HTTP.get uri
    doc = Nokogiri::HTML.parse(body)
    doc.xpath("//section[@class='original-link']/a").first[:href]
  end

  def self.chase_gunosy_url(url)
    body = Net::HTTP.get(URI.parse url)
    doc = Nokogiri::HTML.parse(body)
    begin
      xpath = "//div[@class='article_media clearfix gtm-click']/ul/li/p/a"
      doc.xpath(xpath).first[:href].gsub(/\?ref=gns$/, '')
    rescue
      begin
        doc.xpath("//div[@class='article_cushion_link gtm-click']/a").first[:href]
      rescue
        begin
          xpath = "//div[@class='article gtm-click']/p/a"
          doc.xpath(xpath).first[:href].gsub(/#utm_source=gunosy&.*$/, '')
        rescue
          return url
        end
      end
    end
  end

  def self.chase_hackadoll_url(url)
    uri = URI.parse url
    body = Net::HTTP.get uri
    doc = Nokogiri::HTML.parse(body)
    uri += doc.xpath("//a[@class='btn-read-more anim-hover']").first[:href]

    # 302
    response = Net::HTTP.get_response uri
    response['location']
  end

  def self.chase_moguravr_url(url)
    uri = URI.parse url
    body = Net::HTTP.get(uri)
    doc = Nokogiri::HTML.parse(body)
    xpath = "//div[@class='mg-article-content']/p//a"
    doc.xpath(xpath).last[:href]
  end
  
end

