# 代码生成时间: 2025-08-11 17:00:43
# database_migration_tool.rb
# This script is a utility for database migrations using Ruby on Rails.

require 'active_record'
require 'active_support'
require 'active_record/connection_adapters/abstract_adapter'

# DatabaseMigrationTool class is responsible for handling database migrations.
class DatabaseMigrationTool
  # Initialize the migration tool with connection details.
  def initialize(connection_string)
    @connection_string = connection_string
    @config = YAML.load(ERB.new(File.read('config/database.yml')).result)
    @connection = establish_connection
  end

  # Establish a connection to the database.
  def establish_connection
    ActiveRecord::Base.establish_connection(@config[Rails.env])
    ActiveRecord::Base.connection
  rescue ActiveRecord::ConnectionNotEstablished
    puts "Failed to establish connection to the database."
    nil
  end

  # Migrate the database to the latest version.
  def migrate
    puts "Starting migration..."
    ActiveRecord::MigrationContext.new(ActiveRecord::Migrator.migrations_paths, ActiveRecord::SchemaMigration).migrate
  rescue ActiveRecord::PendingMigrationError => e
    puts "Pending migrations detected: #{e.pending_migrations}"
  rescue ActiveRecord::IrreversibleMigration => e
    puts "Irreversible migration detected: #{e.message}"
  rescue => e
    puts "An error occurred during migration: #{e.message}"
  end

  # Rollback the last migration.
  def rollback
    puts "Rolling back the last migration..."
    ActiveRecord::Migrator.rollback(ActiveRecord::Migrator.migrations_paths, 1)
  rescue ActiveRecord::IrreversibleMigration => e
    puts "Irreversible migration detected: #{e.message}"
  rescue => e
    puts "An error occurred during rollback: #{e.message}"
  end

  # Helper method to run migrations for a specific version.
  def migrate_to(version)
    puts "Migrating to version #{version}..."
    ActiveRecord::Migrator.run(:up, ActiveRecord::Migrator.migrations_paths, version)
  rescue ActiveRecord::IrreversibleMigration => e
    puts "Irreversible migration detected: #{e.message}"
  rescue => e
    puts "An error occurred during migration: #{e.message}"
  end
end

# Example usage:
if __FILE__ == $0
  # Replace 'your_connection_string' with your actual connection string.
  connection_string = 'your_connection_string'
  migration_tool = DatabaseMigrationTool.new(connection_string)
  migration_tool.migrate
  # To rollback the last migration, uncomment the following line:
  # migration_tool.rollback
  # To migrate to a specific version, uncomment the following line and replace '123' with the desired version:
  # migration_tool.migrate_to(123)
end