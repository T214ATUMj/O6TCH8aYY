# 代码生成时间: 2025-09-22 07:07:58
# database_migration_tool.rb

# 这是一个用于数据库迁移的工具，遵循RUBY最佳实践
# 该工具提供了数据库迁移的基本功能，包括迁移和回滚操作。

# 导入必要的库
require 'active_record'
require 'logger'

# 配置ActiveRecord
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db.sqlite3"
)

# 创建Logger对象，用于记录日志
logger = Logger.new(STDOUT)
logger.level = Logger::WARN

# 定义迁移工具类
class DatabaseMigrationTool
  # 执行数据库迁移操作
  def migrate
    begin
      # 获取所有未运行的迁移文件
      pending_migrations = Dir.glob('db/migrate/*.rb').sort.reverse
      pending_migrations.each do |filename|
        # 加载迁移文件
        require_relative filename
        migration_class_name = filename.split('/').last.gsub('.rb', '').camelize
        migration_class = migration_class_name.constantize

        # 确保迁移类存在
        raise "Migration class not found: #{migration_class_name}" unless migration_class.ancestors.include?(ActiveRecord::Migration)

        # 创建迁移实例并执行up方法
        migration_instance = migration_class.new
        migration_instance.migrate(:up)
        logger.info "Migration applied: #{migration_class_name}"
      end
    rescue StandardError => e
      logger.error "Migration failed with error: #{e.message}"
      raise e
    end
  end

  # 执行数据库回滚操作
  def rollback
    begin
      # 获取最近运行的迁移文件
      last_migration = Dir.glob('db/migrate/*.rb').sort.reverse.last
      return unless last_migration

      # 加载迁移文件
      require_relative last_migration
      migration_class_name = last_migration.split('/').last.gsub('.rb', '').camelize
      migration_class = migration_class_name.constantize

      # 创建迁移实例并执行down方法
      migration_instance = migration_class.new
      migration_instance.migrate(:down)
      logger.info "Migration rolled back: #{migration_class_name}"
    rescue StandardError => e
      logger.error "Rollback failed with error: #{e.message}"
      raise e
    end
  end
end

# 创建迁移工具实例
migration_tool = DatabaseMigrationTool.new

# 执行迁移操作
migration_tool.migrate
# 执行回滚操作
# migration_tool.rollback
