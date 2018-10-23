require 'nokogiri'

require 'net/http'
require 'uri'

module OriginalURI
  def self.chase_47news_url(url)
    uri = URI.parse url
    body = Net::HTTP.get uri
    doc = Nokogiri::HTML.parse(body)
    url = doc.xpath("//a[@class='read-more-button']").first[:href]

    # 301
    uri = URI.parse url
    response = Net::HTTP.get_response uri
    while response.code =~ /30[123]/
      url = response['location']
      uri = URI.parse url
      response = Net::HTTP.get_response uri
    end

    utm_regex = %r!\?utm_medium=social&utm_content=.+!
    url = url.sub(utm_regex, '')
    kyodo_regex = %r!^(https?://this\.kiji\.is/[^\?]+)\?c=[0-9]+$!
    url = url.sub(kyodo_regex, '\1')
    url
  end

  def self.chase_smartnews_url(url)
    uri = URI.parse url
    # 301
    response = Net::HTTP.get_response uri
    if response.code =~ /30[123]/
      return response['location']
    end

    body = Net::HTTP.get uri
    doc = Nokogiri::HTML.parse(body)
    doc.xpath("//section[@class='original-link']/a").first[:href]
  end

  def self.chase_line_news_url(url)
    regex = %r!^(https?://lin\.ee/[a-zA-Z0-9]+)(\?utm_.+)?$!
    url = url.sub regex, '\1'

    uri = URI.parse url
    response = Net::HTTP.get_response uri
    if response.code =~ /30[123]/
      url = response['location']
    end
    url
  end

  def self.chase_abema_tv_url(url)
    uri = URI.parse url
    response = Net::HTTP.get_response uri
    if response.code =~ /30[123]/
      url = response['location']
    end
    regex = %r!(https?://abema\.tv/[^\?]+)\?utm_.*!
    url = url.sub regex, '\1'
    url
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
  
end

