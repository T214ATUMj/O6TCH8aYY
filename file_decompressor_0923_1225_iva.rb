# 代码生成时间: 2025-09-23 12:25:09
# 文件名: file_decompressor.rb
# 功能: 使用RUBY和RAILS框架实现压缩文件解压工具
# 作者: 你的名字
# 日期: 2023-04-21

require 'zip'
require 'zlib'
require 'tar'
require 'fileutils'

class FileDecompressor
  # 初始化方法
  def initialize(file_path)
    @file_path = file_path
  end

  # 解压ZIP文件
  def decompress_zip
    begin
      # 使用Zlib库解压ZIP文件
      Zip::File.open(@file_path) do |zip_file|
        zip_file.each do |entry|
          # 提取文件到指定目录
          entry.extract(File.join('extracted', entry.name))
        end
      end
    rescue Zip::Error => e
      # 错误处理：压缩文件损坏或格式不正确
      puts "Error: #{e.message}"
    end
  end

  # 解压TAR文件
  def decompress_tar
    begin
      # 使用Tar库解压TAR文件
      Archive::Tar::Minitar.unpack(@file_path, 'extracted')
    rescue Archive::Tar::Error => e
      # 错误处理：压缩文件损坏或格式不正确
      puts "Error: #{e.message}"
    end
  end

  # 获取文件扩展名
  def get_file_extension
    File.extname(@file_path)
  end

  # 解压文件
  def decompress
    # 根据文件扩展名选择解压方法
    case get_file_extension
    when '.zip'
      decompress_zip
    when '.tar', '.tar.gz', '.tgz', '.tar.bz2'
      decompress_tar
    else
      puts "Unsupported file format"
    end
  end
end

# 示例用法
if __FILE__ == $0
  file_path = 'path/to/your/compressed/file.zip'
  decompressor = FileDecompressor.new(file_path)
  decompressor.decompress
end