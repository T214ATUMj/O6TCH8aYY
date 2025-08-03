# 代码生成时间: 2025-08-03 08:14:20
# file_backup_sync.rb

# 这个Ruby程序是一个文件备份和同步工具，它将指定目录下的文件备份到另一个目录。

require 'fileutils'

class FileBackupSync
  # 初始化方法，设置源目录和目标目录
  def initialize(source_directory, target_directory)
    @source_directory = source_directory
    @target_directory = target_directory
  end

  # 同步文件到目标目录
  def sync_files
    # 检查源目录和目标目录是否存在
    unless Dir.exist?(@source_directory)
      raise 'Source directory does not exist'
    end
    unless Dir.exist?(@target_directory)
      raise 'Target directory does not exist'
    end

    # 获取源目录下的所有文件和子目录
    Dir.glob(File.join(@source_directory, '**', '*')).each do |file_path|
      relative_path = file_path.sub(@source_directory, '')
      target_path = File.join(@target_directory, relative_path)

      # 如果目标路径不存在，则创建目录
      FileUtils.mkdir_p(File.dirname(target_path)) unless Dir.exist?(File.dirname(target_path))

      # 如果是文件，则复制到目标目录
      if File.file?(file_path)
        begin
          FileUtils.cp(file_path, target_path)
          puts "Synced: #{file_path} to #{target_path}"
        rescue => e
          puts "Error syncing file: #{file_path}
#{e.message}"
        end
      # 如果是目录，则递归同步
      elsif File.directory?(file_path)
        next unless Dir.glob(File.join(file_path, '**', '*')).any?
        FileUtils.cp_r(file_path, target_path)
        puts "Synced: Directory #{file_path} to #{target_path}"
      end
    end
  end
end

# 示例用法
if __FILE__ == $0
  # 设置源目录和目标目录
  source_dir = '/path/to/source'
  target_dir = '/path/to/target'

  # 创建文件备份和同步工具的实例
  backup_sync = FileBackupSync.new(source_dir, target_dir)

  # 执行文件同步
  backup_sync.sync_files
end