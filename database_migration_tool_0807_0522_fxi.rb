# 代码生成时间: 2025-08-07 05:22:35
# DatabaseMigrationTool
# A simple Ruby on Rails database migration tool

# Load Rails environment
require_relative 'config/environment'

# DatabaseMigrationTool class
class DatabaseMigrationTool
  # Initialize the tool with a Rails ActiveRecord::Base
  def initialize
    # Check if ActiveRecord is loaded
    raise 'ActiveRecord not loaded' unless defined?(ActiveRecord)
  end

  # Migrate the database up
  def migrate_up
    ActiveRecord::Migrator.migrations_paths = Rails.application.paths['db/migrate'].first
    ActiveRecord::Migrator.migrate ActiveRecord::Migrator.migrations_paths, nil
  end

  # Migrate the database down
  def migrate_down
    ActiveRecord::Migrator.migrations_paths = Rails.application.paths['db/migrate'].first
    ActiveRecord::Migrator.rollback ActiveRecord::Migrator.migrations_paths, 1
  end

  # Migrate the database to a specific version
  def migrate_to(version)
    ActiveRecord::Migrator.migrations_paths = Rails.application.paths['db/migrate'].first
    ActiveRecord::Migrator.migrate ActiveRecord::Migrator.migrations_paths, version
  end

  # Check the current migration version
  def current_version
    ActiveRecord::Migrator.current_version
  end

  # List all migrations
  def list_migrations
    ActiveRecord::Migrator.migrations_paths = Rails.application.paths['db/migrate'].first
    ActiveRecord::Migrator.migrations.collect { |m| m.name }
  end
end

# Usage example
if __FILE__ == $0
  tool = DatabaseMigrationTool.new
  puts 'Current migration version: ' + tool.current_version.to_s
  puts 'Listing all migrations:'
  p tool.list_migrations
  puts 'Migrating up...'
  tool.migrate_up
  puts 'Migrating down...'
  tool.migrate_down
end