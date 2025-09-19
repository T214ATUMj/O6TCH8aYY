# 代码生成时间: 2025-09-19 19:45:07
# MathCalculator is a Ruby on Rails service class that provides a set of mathematical operations.
class MathCalculator
  # Adds two numbers and returns the result.
  def add(a, b)
    raise ArgumentError, 'Both arguments must be numbers' unless a.is_a?(Numeric) && b.is_a?(Numeric)
    a + b
  end

  # Subtracts the second number from the first and returns the result.
  def subtract(a, b)
    raise ArgumentError, 'Both arguments must be numbers' unless a.is_a?(Numeric) && b.is_a?(Numeric)
    a - b
  end

  # Multiplies two numbers and returns the result.
  def multiply(a, b)
    raise ArgumentError, 'Both arguments must be numbers' unless a.is_a?(Numeric) && b.is_a?(Numeric)
    a * b
  end

  # Divides the first number by the second number and returns the result.
  def divide(a, b)
    raise ArgumentError, 'Both arguments must be numbers' if a.is_a?(Numeric) && b.is_a?(Numeric) && b == 0
    a / b
  rescue ZeroDivisionError => e
    raise ArgumentError, 'Cannot divide by zero'
  end

  # Calculates the power of one number to another (exponentiation) and returns the result.
  def power(a, b)
    raise ArgumentError, 'Both arguments must be numbers' unless a.is_a?(Numeric) && b.is_a?(Numeric)
    a ** b
  end

  # Calculates the square root of a number and returns the result.
  def square_root(a)
    raise ArgumentError, 'Argument must be a non-negative number' unless a.is_a?(Numeric) && a >= 0
    Math.sqrt(a)
  end
end

# Usage example:
# calculator = MathCalculator.new
# result = calculator.add(5, 3)
# puts result # => 8