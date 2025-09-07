# 代码生成时间: 2025-09-07 10:17:18
# user_permission_system.rb

# 引入Rails框架
require 'rails'
require 'active_record'

# 用户模型
class User < ActiveRecord::Base
  # 关联权限模型
  has_many :permissions

  # 检查用户是否具有指定权限
  def has_permission?(permission_name)
    permissions.where(name: permission_name).any?
  end
end

# 权限模型
class Permission < ActiveRecord::Base
  # 关联用户模型
  belongs_to :user
end

# 用户权限管理服务类
class UserPermissionService
  # 添加权限给用户
  def self.add_permission(user, permission_name)
    # 检查权限是否存在，不存在则创建
    permission = Permission.find_or_create_by!(name: permission_name)
    user.permissions << permission unless user.permissions.include?(permission)
  rescue ActiveRecord::RecordInvalid => e
    # 处理错误，如权限已存在等
    puts "Error adding permission: #{e.message}"
  end

  # 删除用户权限
  def self.remove_permission(user, permission_name)
    permission = Permission.find_by(name: permission_name)
    if permission && user.permissions.include?(permission)
      user.permissions.delete(permission)
    else
      # 处理错误，如权限不存在或用户没有该权限
      puts "Error removing permission: Permission not found or user does not have the permission"
    end
  rescue ActiveRecord::RecordNotFound => e
    puts "Error removing permission: #{e.message}"
  end
end

# 错误处理示例
begin
  # 创建用户实例
  user = User.new(name: 'John Doe')
  user.save
  
  # 添加权限给用户
  UserPermissionService.add_permission(user, 'edit_post')
  
  # 检查用户是否具有权限
  puts "User has 'edit_post' permission: #{user.has_permission?('edit_post')}"

  # 删除权限
  UserPermissionService.remove_permission(user, 'edit_post')
  
  # 再次检查用户是否具有权限
  puts "User has 'edit_post' permission after removal: #{user.has_permission?('edit_post')}"
rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
  puts "An error occurred: #{e.message}"
end