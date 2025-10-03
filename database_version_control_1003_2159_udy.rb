# 代码生成时间: 2025-10-03 21:59:42
# 控制数据库版本的命令
class DbVersion < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  # 定义迁移版本号
  desc "Create a new migration for database version control"
  argument :version, type: :string, required: true, banner: 'version', desc: 'Specify the version number'

  # 执行迁移文件创建操作
  def create_migration_file
    migration_template 'migration.rb', "db/migrate/create_db_version_control_#{version}.rb"
  end

  # 添加数据库版本控制表和记录的迁移文件
  def add_migration_content
    unless version.nil?
      # 使用模板生成迁移文件内容
      migration_content = <<-RUBY.strip_heredoc
        class CreateDbVersionControl_#{version} < ActiveRecord::Migration[#{ActiveRecord::Migration.current_version}]
          def change
            create_table :db_versions do |t|
              t.string :version, null: false
              t.timestamps null: false
            end

            add_index :db_versions, :version, unique: true
          end
        end
      RUBY
      # 将迁移文件内容写入文件
      create_file "db/migrate/create_db_version_control_#{version}.rb", migration_content
    end
  rescue StandardError => e
    puts "Error creating migration file: #{e.message}"
  end

  # 执行数据库版本控制的迁移操作
  def migrate_db
    unless version.nil?
      `bundle exec rails db:migrate`
    rescue StandardError => e
      puts "Error during migration: #{e.message}"
    end
  end
end

# 定义迁移模板
module Templates
  module Migration
    # 迁移文件模板
    def migration_template(*args, &block)
      template(*args, &block)
    end
  end
end

# 注册迁移模板
Rails::Generators.include(Templates::Migration)
