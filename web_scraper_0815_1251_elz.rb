# 代码生成时间: 2025-08-15 12:51:38
# web_scraper.rb
# This script is a simple web scraper application using Ruby and Nokogiri gem for parsing HTML.

require 'nokogiri'
require 'open-uri'
require 'uri'

class WebScraper
  # Initializes the scraper with the URL to be scraped
  def initialize(url)
    @url = url
  end

  # Scrapes the content of the webpage at the given URL
  def scrape
    begin
      # Open the URL and read the content
      html_content = open(@url).read
      # Parse the HTML content using Nokogiri
      doc = Nokogiri::HTML(html_content)
      doc
    rescue OpenURI::HTTPError => e
      # Handle HTTP errors (e.g., 404, 500, etc.)
      puts "HTTP Error: #{e.message}"
      nil
    rescue URI::InvalidURIError => e
      # Handle invalid URI errors
      puts "Invalid URI Error: #{e.message}"
      nil
    rescue => e
      # Handle any other unexpected errors
      puts "An unexpected error occurred: #{e.message}"
      nil
    end
  end
end

# Example usage:
# scraper = WebScraper.new("http://example.com")
# doc = scraper.scrape
# if doc
#   puts "Scraping successful!"
#   # Further processing on the doc object can be done here
# else
#   puts "Failed to scrape the webpage."
# end