# 代码生成时间: 2025-08-24 08:44:26
# 文件备份和同步工具
# file_backup_sync_tool.rb

require 'fileutils'
require 'digest'

# 文件备份同步工具类
class FileBackupSyncTool
  # 初始化备份同步工具
  # @param source_path [String] 源文件路径
  # @param backup_path [String] 备份文件路径
  def initialize(source_path, backup_path)
    @source_path = source_path
    @backup_path = backup_path
  end

  # 同步文件
  # @return [Boolean] 同步是否成功
  def sync_files
    begin
      # 检查源路径和备份路径是否存在
      raise '源路径不存在' unless File.exist?(@source_path)
      raise '备份路径不存在' unless File.exist?(@backup_path)

      # 获取源目录和备份目录下的所有文件
      source_files = Dir.glob(File.join(@source_path, '*'))
      backup_files = Dir.glob(File.join(@backup_path, '*'))

      # 遍历源目录下的所有文件
      source_files.each do |file|
        # 获取文件名
        filename = File.basename(file)

        # 检查备份目录下是否存在同名文件
        backup_file = File.join(@backup_path, filename)
        if File.exist?(backup_file)
          # 如果存在，比较文件内容是否一致
          if File.read(file) == File.read(backup_file)
            # 文件内容一致，跳过
            next
          else
            # 文件内容不一致，备份原文件并替换
            backup_original(backup_file)
            FileUtils.cp(file, backup_file)
          end
        else
          # 如果不存在，直接复制文件
          FileUtils.cp(file, backup_file)
        end
      end

      # 删除备份目录下多余的文件
      backup_files.each do |file|
        filename = File.basename(file)
        unless File.exist?(File.join(@source_path, filename))
          FileUtils.rm(file)
        end
      end

      true
    rescue => e
      puts "同步失败：#{e.message}"
      false
    end
  end

  # 备份原文件
  # @param file_path [String] 要备份的文件路径
  def backup_original(file_path)
    # 生成备份文件名
    backup_file = File.join(File.dirname(file_path), "#{File.basename(file_path)}.original")
    # 复制文件
    FileUtils.cp(file_path, backup_file)
  end
end

# 示例用法
if __FILE__ == $0
  # 源文件路径
  source_path = '/path/to/source'
  # 备份文件路径
  backup_path = '/path/to/backup'

  # 创建文件备份同步工具实例
  tool = FileBackupSyncTool.new(source_path, backup_path)

  # 同步文件
  if tool.sync_files
    puts '文件同步成功'
  else
    puts '文件同步失败'
  end
end