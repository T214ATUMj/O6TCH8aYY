# 代码生成时间: 2025-08-24 22:15:21
# inventory_management.rb
# This is a simple inventory management system using Ruby on Rails.

require 'rails'
require 'active_record'
require 'sqlite3'

# Define a database connection
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'inventory.db')

# Define an ActiveRecord model for Products
class Product < ActiveRecord::Base
  # Validations
  validates :name, presence: true, length: { minimum: 2 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  
  # Method to add a new product
  def self.add_product(name, quantity)
    product = Product.new(name: name, quantity: quantity)
    if product.save
      puts "Product added successfully."
    else
      puts "Failed to add product: #{product.errors.full_messages.join(', ')}"
    end
  end

  # Method to update product quantity
  def self.update_quantity(product_id, new_quantity)
    product = Product.find(product_id)
    if product.update(quantity: new_quantity)
      puts "Quantity updated successfully."
    else
      puts "Failed to update quantity: #{product.errors.full_messages.join(', ')}"
    end
  end
end

# Create the database schema
ActiveRecord::Schema.define do
  # Create a table for products
  create_table :products, force: true do |t|
    t.string :name, null: false
    t.integer :quantity, null: false
  end
end

# Example usage
Product.add_product("Widget", 100)
Product.update_quantity(1, 150)

# Main program logic
puts "Starting Inventory Management System..."
# You can add more complex program logic here
