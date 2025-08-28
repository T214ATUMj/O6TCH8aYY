# 代码生成时间: 2025-08-28 11:50:54
# 库存管理系统
#
# 功能：管理库存项的添加、删除、更新和查询。
#
class InventoryManagement
  # 库存项类
  class Item
    attr_accessor :id, :name, :quantity
    # 构造方法
    def initialize(id, name, quantity)
      @id = id
      @name = name
      @quantity = quantity
    end
  end

  # 库存管理器类
  class Manager
    attr_reader :inventory
    def initialize
      @inventory = {}
    end

    # 添加库存项
    def add_item(id, name, quantity)
      if @inventory.has_key?(id)
        raise 'Item with the same ID already exists.'
      else
        @inventory[id] = Item.new(id, name, quantity)
      end
    end

    # 删除库存项
    def remove_item(id)
      if @inventory.has_key?(id)
        @inventory.delete(id)
      else
        raise 'Item not found.'
      end
    end

    # 更新库存项数量
    def update_quantity(id, new_quantity)
      if @inventory.has_key?(id)
        @inventory[id].quantity = new_quantity
      else
        raise 'Item not found.'
      end
    end

    # 查询库存项
    def find_item(id)
      @inventory[id]
    end
  end

  # 管理器实例化
  def self.manager
    Manager.new
  end
end

# 测试代码
begin
  manager = InventoryManagement.manager
  manager.add_item(1, 'Apple', 100)
  manager.add_item(2, 'Banana', 200)

  puts 'Apple quantity: ' + manager.find_item(1).quantity.to_s
  puts 'Banana quantity: ' + manager.find_item(2).quantity.to_s

  manager.update_quantity(1, 150)
  puts 'Apple quantity after update: ' + manager.find_item(1).quantity.to_s

  begin
    manager.remove_item(3)
  rescue => e
    puts e.message
  end

  begin
    puts 'Item 3: ' + manager.find_item(3).name
  rescue => e
    puts e.message
  end
rescue => e
  puts e.message
end