# 代码生成时间: 2025-08-21 07:50:12
# RandomNumberGenerator class
# This class is responsible for generating random numbers.
class RandomNumberGenerator
  # Initialize with minimum and maximum values
  def initialize(min, max)
    @min = min
    @max = max
    validate_range
  end

  # Generate a random number within the initialized range
  def generate
    return rand(@min..@max)
  end

  private

  # Validate that the minimum is less than the maximum
  def validate_range
    unless @min < @max
      raise ArgumentError, 'Minimum value must be less than maximum value'
    end
  end
end

# Usage example
begin
  rng = RandomNumberGenerator.new(1, 100)
  puts(rng.generate)
rescue ArgumentError => e
  puts e.message
end