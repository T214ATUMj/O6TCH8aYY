# 代码生成时间: 2025-08-25 16:19:14
# json_data_converter.rb
# This is a simple JSON data formatter built with Ruby and Rails.
# It provides a clear structure and includes error handling,
# comments, and follows Ruby best practices for maintainability and extensibility.

# Require necessary libraries
require 'json'
require 'active_support/core_ext/hash/indifferent_access'

class JsonDataConverter
  # Convert a Ruby hash to a JSON string
  def self.to_json(hash)
    hash.with_indifferent_access.to_json
  end

  # Convert a JSON string to a Ruby hash
  def self.from_json(json_string)
    JSON.parse(json_string)
  rescue JSON::ParserError => e
    puts "Error parsing JSON: #{e.message}"
    nil
  end
end
