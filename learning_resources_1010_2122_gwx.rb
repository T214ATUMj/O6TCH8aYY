# 代码生成时间: 2025-10-10 21:22:27
# learning_resources.rb
# This Ruby on Rails program represents a simple Learning Resources Library.

class LearningResourcesLibrary
  # Initialize with an empty resource collection
  def initialize
    @resources = []
  end

  # Add a new learning resource to the library
  # @param resource [Hash] The details of the resource to be added
  def add_resource(resource)
    unless resource.is_a?(Hash) && resource.values.all?(&:present?)
      raise ArgumentError, 'Resource must be a non-empty hash with all values present.'
    end
    @resources.push(resource)
  end

  # Find a resource by its unique identifier
  # @param id [Integer] The unique identifier of the resource
  # @return [Hash] The resource if found, nil otherwise
  def find_resource_by_id(id)
    @resources.find { |resource| resource[:id] == id }
  end

  # List all resources in the library
  # @return [Array<Hash>] An array of all resources
  def list_resources
    @resources
  end

  # Remove a resource from the library by its unique identifier
  # @param id [Integer] The unique identifier of the resource to remove
  def remove_resource(id)
    @resources.reject! { |resource| resource[:id] == id }
  end

  # Update an existing resource in the library
  # @param id [Integer] The unique identifier of the resource to update
  # @param new_details [Hash] The new details for the resource
  def update_resource(id, new_details)
    resource = find_resource_by_id(id)
    unless resource
      raise ArgumentError, 'Resource not found.'
    end
    resource.merge!(new_details)
  end
end

# Example usage
library = LearningResourcesLibrary.new

begin
  # Adding resources
  library.add_resource(id: 1, title: 'Ruby on Rails Guide', author: 'Someone', published: '2023')
  library.add_resource(id: 2, title: 'The Art of Computer Programming', author: 'Donald E. Knuth', published: '1968')

  # Listing resources
  puts 'Resources:'
  library.list_resources.each do |resource|
    p resource
  end

  # Updating a resource
  library.update_resource(1, {author: 'Updated Author'})

  # Finding a resource by ID
  resource = library.find_resource_by_id(1)
  if resource
    p 'Found resource:'
    p resource
  end

  # Removing a resource
  library.remove_resource(2)
  puts 'Resources after removal:'
  library.list_resources.each do |resource|
    p resource
  end
rescue ArgumentError => e
  puts "Error: #{e.message}"
end