# 代码生成时间: 2025-08-28 23:46:17
# web_scraper.rb
require 'open-uri'
require 'nokogiri'

# WebScraper class is responsible for fetching and parsing web content.
class WebScraper
  # Initializes the scraper with a URL.
  def initialize(url)
    @url = url
  end

  # Fetches the content of the webpage.
  # Returns the HTML content as a string.
  def fetch_content
    begin
      open(@url).read
    rescue OpenURI::HTTPError => e
      puts "Error fetching content: #{e.message}"
      nil
    end
  end

  # Parses the HTML content and returns an Nokogiri::HTML object.
  # This method assumes that #fetch_content has been called before.
  def parse_content
    return unless @content

    Nokogiri::HTML(@content)
  end

  # Extracts specific elements from the parsed HTML.
  # Uses CSS selectors to find elements.
  # Returns an array of Nokogiri::XML::Element objects.
  def extract_elements(selector)
    return [] unless @content

    doc = parse_content
    doc.css(selector)
  end

  private

  # Sets the content of the webpage.
  def content=(content)
    @content = content
  end
end

# Usage
if __FILE__ == $0
  url = 'http://example.com'
  scraper = WebScraper.new(url)
  scraper.content = scraper.fetch_content
  elements = scraper.extract_elements('body')
  elements.each do |element|
    puts element.text
  end
end