# 代码生成时间: 2025-10-04 03:51:18
# RandomNumberGenerator.rb
#
# This Ruby on Rails service class provides a simple random number generator.
#
# Usage:
# RandomNumberGenerator.call(min: 1, max: 100)
#
class RandomNumberGenerator
  # Generates a random number within a specified range.
  #
  # @param options [Hash] A hash containing the minimum and maximum values.
  # @option options :min [Integer] The minimum value of the range (inclusive).
  # @option options :max [Integer] The maximum value of the range (inclusive).
  # @return [Integer] A random number within the specified range.
  # @raise [ArgumentError] If the minimum value is greater than the maximum value.
  #
  def self.call(options)
    min = options.fetch(:min) { raise ArgumentError, 'Minimum value is required' }
    max = options.fetch(:max) { raise ArgumentError, 'Maximum value is required' }

    if min > max
      raise ArgumentError, 'Minimum value cannot be greater than the maximum value'
    end

    rand(min..max)
  end
end