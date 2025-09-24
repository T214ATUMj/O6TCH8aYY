# 代码生成时间: 2025-09-24 09:31:32
# sorting_algorithms.rb
# This Ruby script implements several sorting algorithms.

# Bubble Sort Algorithm
def bubble_sort(arr)
  n = arr.length
  loop do
    swapped = false
    (0...n-1).each do |i|
      if arr[i] > arr[i+1]
        arr[i], arr[i+1] = arr[i+1], arr[i]
        swapped = true
      end
    end
    break unless swapped
    n -= 1
  end
  arr
end

# Quick Sort Algorithm
def quick_sort(arr)
  return [] if arr.length <= 1
  pivot = arr.first
  left = arr[1..-1].select { |x| x <= pivot }
  right = arr[1..-1].select { |x| x > pivot }
  [quick_sort(left), [pivot], quick_sort(right)].flatten
end

# Insertion Sort Algorithm
def insertion_sort(arr)
  (1...arr.length).each do |i|
    key = arr[i]
    j = i - 1
    while j >= 0 && arr[j] > key
      arr[j + 1] = arr[j]
      j -= 1
    end
    arr[j + 1] = key
  end
  arr
end

# Merge Sort Algorithm
def merge_sort(arr)
  return arr if arr.length <= 1
  mid = arr.length / 2
  left_half = arr[0...mid]
  right_half = arr[mid..-1]
  merge(merge_sort(left_half), merge_sort(right_half))
end

def merge(left, right)
  merged = []
  while left.any? && right.any?
    if left.first <= right.first
      merged << left.shift
    else
      merged << right.shift
    end
  end
  merged + left + right
end

# Driver code to test the sorting algorithms
if __FILE__ == $0
  arr = [64, 34, 25, 12, 22, 11, 90]
  puts "Original array: #{arr}"
  puts "Sorted array by Bubble Sort: #{bubble_sort(arr.dup)}"
  puts "Sorted array by Quick Sort: #{quick_sort(arr.dup)}"
  puts "Sorted array by Insertion Sort: #{insertion_sort(arr.dup)}"
  puts "Sorted array by Merge Sort: #{merge_sort(arr.dup)}"
end