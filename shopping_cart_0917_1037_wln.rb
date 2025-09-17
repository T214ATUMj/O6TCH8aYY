# 代码生成时间: 2025-09-17 10:37:35
# shopping_cart.rb
# Shopping cart functionality for a Rails application

class ShoppingCart
  # Initialize an empty cart
  def initialize
    @items = []
  end

  # Add an item to the cart
  # item: the item to be added to the cart (expected to be a hash with at least :name and :price keys)
  def add_item(item)
    if item && item.is_a?(Hash) && item.has_key?(:name) && item.has_key?(:price)
      @items.push(item)
    else
      raise ArgumentError, "Invalid item. Item must be a hash with :name and :price keys."
    end
  end

  # Remove an item from the cart by name
  # item_name: the name of the item to be removed from the cart
  def remove_item(item_name)
    @items.delete_if { |item| item[:name] == item_name }
  rescue StandardError => e
    puts "Error removing item: #{e.message}"
  end

  # Update the quantity of an item in the cart
  # item_name: the name of the item to be updated
  # quantity: the new quantity of the item
  def update_item_quantity(item_name, quantity)
    item = @items.find { |item| item[:name] == item_name }
    if item && quantity.is_a?(Integer) && quantity > 0
      item[:quantity] = quantity
    else
      raise ArgumentError, "Invalid item or quantity. Item must exist and quantity must be a positive integer."
    end
  end

  # Get the total price of all items in the cart
  def total_price
    @items.sum { |item| item[:price] * (item[:quantity] || 1) }
  end

  # Get a list of all items in the cart
  def items
    @items
  end
end
