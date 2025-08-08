# 代码生成时间: 2025-08-08 15:46:17
# sorting_algorithm.rb
# This Ruby script implements a sorting algorithm using Rails best practices.

class SortingAlgorithm
  # Bubble Sort implementation
  # @param array [Array] The array to be sorted
  # @return [Array] The sorted array
  def self.bubble_sort(array)
    array.dup.each do |_element|
      (array.length - 1).times do |i|
        unless array[i] <= array[i + 1]
          # Swap elements if they are in the wrong order
          array[i], array[i + 1] = array[i + 1], array[i]
        end
      end
    end
    array
  end

  # Selection Sort implementation
  # @param array [Array] The array to be sorted
  # @return [Array] The sorted array
  def self.selection_sort(array)
    array.dup.each_with_index do |_element, i|
      (min_index, *remaining_elements) = remaining_elements.min_by { |idx| array[idx] }
      array[i], array[min_index] = array[min_index], array[i] if i != min_index
    end
    array
  end

  # Insertion Sort implementation
  # @param array [Array] The array to be sorted
  # @return [Array] The sorted array
  def self.insertion_sort(array)
    array.each_cons(2).each_with_index do |(a, b), i|
      sorted_array = [a]
      sorted_array << b if i.zero? || sorted_array.last <= b
      array[i..max(i + 1, 0)] = sorted_array
    end
    array
  end

  # Error handling for non-array inputs
  # @param array [Array] The input to be checked
  # @raise [ArgumentError] if the input is not an array
  def self.validate_input(array)
    raise ArgumentError, 'Input must be an array' unless array.is_a?(Array)
  end
end

# Example usage
begin
  array_to_sort = [5, 3, 8, 1, 6]
  SortingAlgorithm.validate_input(array_to_sort)
  puts 'Sorted array using Bubble Sort:'
  p SortingAlgorithm.bubble_sort(array_to_sort.dup)
  puts 'Sorted array using Selection Sort:'
  p SortingAlgorithm.selection_sort(array_to_sort.dup)
  puts 'Sorted array using Insertion Sort:'
  p SortingAlgorithm.insertion_sort(array_to_sort.dup)
rescue ArgumentError => e
  puts "Error: #{e.message}"
end