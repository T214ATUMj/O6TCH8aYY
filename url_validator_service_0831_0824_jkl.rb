# 代码生成时间: 2025-08-31 08:24:46
# url_validator_service.rb
require 'net/http'
require 'uri'

# Validates the URL for its existence and accessibility.
class URLValidatorService
  # Validates the given URL.
  #
  # @param [String] url The URL to validate.
  # @return [Boolean] true if the URL is valid, false otherwise.
  def self.validate(url)
    # Check if the URL is nil or empty
    return false if url.nil? || url.strip.empty?

    begin
      # Parse the URL and check if it's valid
      uri = URI(url)
      # Use the Net::HTTP library to check if the URL is accessible
      Net::HTTP.start(uri.hostname, uri.port) do |http|
        response = http.request_head(URI.encode(uri.request_uri))
        # If the response code is between 200 and 299, the URL is valid
        return response.code.to_i >= 200 && response.code.to_i < 300
      end
    rescue URI::InvalidURIError, SocketError, Net::HTTPServerException
      # If any of these exceptions are raised, the URL is not valid
      return false
    end
  end
end
