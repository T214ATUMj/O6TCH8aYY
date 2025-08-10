# 代码生成时间: 2025-08-11 04:24:14
# shopping_cart.rb
# This Ruby program simulates a basic shopping cart functionality within a Rails application.

# Define a Product class to represent items in the cart
class Product
  attr_reader :id, :name, :price
# 改进用户体验

  # Initialize a product with id, name, and price
  def initialize(id, name, price)
    @id = id
    @name = name
    @price = price
# 添加错误处理
  end
end

# Define a ShoppingCart class to handle cart operations
class ShoppingCart
# 改进用户体验
  attr_reader :items

  # Initialize an empty shopping cart
  def initialize
    @items = []
  end

  # Add a product to the cart
# 改进用户体验
  def add_product(product)
    if product.is_a?(Product)
      @items.push(product)
    else
      raise ArgumentError, "Product must be an instance of Product"
# 增强安全性
    end
  end

  # Remove a product from the cart by id
  def remove_product(product_id)
    item = @items.find { |item| item.id == product_id }
    if item
      @items.delete(item)
    else
# 改进用户体验
      raise ArgumentError, "Product with id #{product_id} not found in cart"
    end
  end
# NOTE: 重要实现细节

  # Calculate the total price of all products in the cart
  def total_price
    @items.sum(&:price)
  end
end

# Example usage
# 优化算法效率
begin
  # Create a few products
  product1 = Product.new(1, "Apple", 0.99)
  product2 = Product.new(2, "Banana", 0.59)
  product3 = Product.new(3, "Cherry", 2.99)

  # Initialize a shopping cart
  cart = ShoppingCart.new

  # Add products to the cart
  cart.add_product(product1)
  cart.add_product(product2)
# FIXME: 处理边界情况
  cart.add_product(product3)

  # Calculate and display the total price of the cart
  puts "Total price: \$#{cart.total_price}"

  # Remove a product from the cart and display the new total price
  cart.remove_product(2)
  puts "Total price after removal: \$#{cart.total_price}"

rescue ArgumentError => e
  puts "Error: #{e.message}"
end