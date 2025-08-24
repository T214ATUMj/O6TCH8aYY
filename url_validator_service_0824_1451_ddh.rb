# 代码生成时间: 2025-08-24 14:51:49
# url_validator_service.rb
# This service is responsible for validating the validity of a given URL.

require 'net/http'
require 'uri'

class UrlValidatorService
  # Validates the URL by checking if it is valid and reachable.
  #
  # @param url [String] The URL to be validated.
  # @return [Boolean] true if the URL is valid and reachable, false otherwise.
  def self.validate_url(url)
    # Check if the URL is nil or empty
    return false if url.nil? || url.empty?

    # Create a URI object from the URL string
    uri = URI.parse(url)

    # Check if the URI is valid
    return false unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)

    # Use Net::HTTP to get the response from the URL
    begin
      # Open the HTTP session with a timeout of 10 seconds
      Net::HTTP.start(uri.host, uri.port, read_timeout: 10) do |http|
        request = Net::HTTP::Get.new(uri.request_uri)

        # Send the request and get the response
        response = http.request(request)

        # Check if the response code is in the 2xx range (successful request)
        response.code.match?(/^2\d{2}$/)
      end
    rescue StandardError => e
      # Log the error and return false if any error occurs
      Rails.logger.error "URL validation error: #{e.message}"
      false
    end
  end
end