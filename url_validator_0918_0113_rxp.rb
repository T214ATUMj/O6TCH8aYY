# 代码生成时间: 2025-09-18 01:13:29
# url_validator.rb
# A simple Ruby on Rails service that validates the validity of a URL.
require 'net/http'
require 'uri'

# Validates URL links. This class is responsible for checking if a given URL is valid.
class UrlValidator
  # Public: Validates the given URL.
  #
  # url - A String representation of the URL to be validated.
  #
  # Returns a Boolean indicating whether the URL is valid or not.
  def self.validate_url(url)
    # Check if the URL is present and not empty.
    return false if url.blank?

    # Parse the URL and check if it is well-formed.
    uri = URI.parse(url)
    return false unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)

    # Make a HEAD request to check if the URL is reachable.
    begin
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      response = http.head(uri.path)

      # Check if the response is successful (status code in the 2xx range).
      return response.is_a?(Net::HTTPSuccess)
    rescue StandardError
      # If any error occurs (e.g., network issues, invalid domain), return false.
      false
    end
  end

  # Private: Formats the error message for the validation failure.
  private_class_method

  def self.format_error_message(url)
    "The URL '#{url}' is not valid."
  end
end
