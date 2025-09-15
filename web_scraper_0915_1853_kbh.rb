# 代码生成时间: 2025-09-15 18:53:19
# web_scraper.rb
# This script is a basic web scraper built with Ruby and Nokogiri gem.
# It is designed to fetch content from a web page and print it out.

require 'nokogiri'
require 'open-uri'
require 'pp'

class WebScraper
  # Initializer method to set the target URL
  def initialize(url)
    @url = url
  end

  # Method to fetch and parse the web page content
  def fetch_content
    begin
      # Open the URL and read the content
      content = open(@url).read
      # Parse the content using Nokogiri
      doc = Nokogiri::HTML(content)
      doc
    rescue OpenURI::HTTPError => e
      # Handle HTTP errors
      puts "Error fetching content: #{e.message}"
      nil
    rescue Nokogiri::XML::XPath::SyntaxError => e
      # Handle parsing errors
      puts "Error parsing content: #{e.message}"
      nil
    rescue StandardError => e
      # Handle any other standard errors
      puts "An unexpected error occurred: #{e.message}"
      nil
    end
  end

  # Method to extract and return the title of the web page
  def get_title
    doc = fetch_content
    return nil if doc.nil?
    doc.at_css('title')&.text
  end

  # Method to extract and return the main content of the web page
  def get_main_content
    doc = fetch_content
    return nil if doc.nil?
    main_content = doc.css('main')
    main_content.empty? ? nil : main_content.first.text.strip
  end
end

# Example usage
if __FILE__ == $0
  url_to_scrape = 'https://example.com'
  scraper = WebScraper.new(url_to_scrape)
  title = scraper.get_title
  puts "Title: #{title}" unless title.nil?
  main_content = scraper.get_main_content
  puts "Main Content: #{main_content}" unless main_content.nil?
end
