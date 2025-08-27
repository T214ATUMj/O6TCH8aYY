# 代码生成时间: 2025-08-27 14:16:10
# DataBackupRestore Service
# This service handles data backup and restore functionalities.

class DataBackupRestore
  attr_accessor :backup_path, :source_path

  # Initialize the service with the backup and source paths
  def initialize(backup_path, source_path)
    @backup_path = backup_path
    @source_path = source_path
  end

  # Perform a backup of the data from the source path to the backup path
  def backup
    unless File.directory?(@source_path)
      raise 'Source path is not a directory'
    end

    unless File.exist?(@backup_path)
      FileUtils.mkdir_p(@backup_path)
    end

    entries = Dir.entries(@source_path) - ['.', '..']
    entries.each do |entry|
      src_entry_path = File.join(@source_path, entry)
      backup_entry_path = File.join(@backup_path, entry)

      if File.directory?(src_entry_path)
        FileUtils.cp_r(src_entry_path, backup_entry_path)
      else
        FileUtils.cp(src_entry_path, backup_entry_path)
      end
    end

    "Backup completed successfully."
  rescue => e
    "Error during backup: #{e.message}"
  end

  # Restore data from the backup path to the source path
  def restore
    unless File.directory?(@backup_path)
      raise 'Backup path is not a directory'
    end

    unless File.exist?(@source_path)
      FileUtils.mkdir_p(@source_path)
    end

    entries = Dir.entries(@backup_path) - ['.', '..']
    entries.each do |entry|
      backup_entry_path = File.join(@backup_path, entry)
      src_entry_path = File.join(@source_path, entry)

      if File.directory?(backup_entry_path)
        FileUtils.cp_r(backup_entry_path, src_entry_path)
      else
        FileUtils.cp(backup_entry_path, src_entry_path)
      end
    end

    "Restore completed successfully."
  rescue => e
    "Error during restore: #{e.message}"
  end
end

# Example usage:
# backup_service = DataBackupRestore.new('/path/to/backup', '/path/to/source')
# result = backup_service.backup
# puts result
# restore_service = DataBackupRestore.new('/path/to/backup', '/path/to/source')
# result = restore_service.restore
# puts result
