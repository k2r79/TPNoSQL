require 'nokogiri'
require 'open-uri'
require_relative 'worker'

class Crawler < Worker

  def process
    super

    puts "Parsing : #{@args['url']} ..."

    page = Nokogiri::HTML(open(@args['url']))

    links = page.xpath("//a").map {
        |link| link.attribute('href').to_s
    }.delete_if {
        |href| href.empty? || /^(\s|\/|#|javascript:.*)$/.match(href)
    }.uniq

    @results = {
        title: page.css("title").first.text || "",
        description: page.xpath("//meta[@name='description']/@content").text || "",
        links: links,
    };
  end

end