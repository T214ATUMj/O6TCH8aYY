# 代码生成时间: 2025-08-13 17:05:13
# data_generator.rb
#
# This script is a simple data generator for testing purposes.
# It creates a specified number of test records in the database.

require 'active_record'
require 'faker'

# Assuming a 'User' model exists in the Rails application.
class DataGenerator
  # Initialize with the number of records to generate.
  def initialize(number_of_records)
    @number_of_records = number_of_records
  end

  # Generate test data.
  def generate
    return unless valid_number_of_records?

    puts "Generating #{@number_of_records} test records..."
    User.transaction do
      @number_of_records.times do
        User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: Faker::Internet.password
        )
      end
    end
    puts "Test records generated successfully."
  rescue ActiveRecord::RecordInvalid => e
    puts "Error generating test data: #{e.message}"
  end

  private

  # Check if the number of records is a positive integer.
  def valid_number_of_records?
    return false unless @number_of_records.is_a?(Integer)
    return false if @number_of_records <= 0
    true
  end
end

# Example usage:
# generator = DataGenerator.new(10)
# generator.generate