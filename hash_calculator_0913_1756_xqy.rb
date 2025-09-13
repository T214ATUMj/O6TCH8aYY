# 代码生成时间: 2025-09-13 17:56:03
# hash_calculator.rb

require 'digest'

# HashCalculator is a utility class for calculating hash values.
class HashCalculator
  # Calculates the hash of a given string using SHA256 algorithm.
  #
  # @param [String] input The string to be hashed.
  # @return [String] The SHA256 hash of the input string.
  # @raise [ArgumentError] If the input is not a string.
  def calculate_sha256(input)
    unless input.is_a?(String)
      raise ArgumentError, 'Input must be a string.'
    end
    
    digest = Digest::SHA256.hexdigest(input)
    puts "Hash calculated: #{digest}"
    digest
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
    nil
  end
end

# Example usage:
# hash_calculator = HashCalculator.new
# hash_value = hash_calculator.calculate_sha256("hello world")
# puts "The SHA256 hash is: #{hash_value}"