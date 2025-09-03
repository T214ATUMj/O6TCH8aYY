# 代码生成时间: 2025-09-03 19:42:43
# 文件名: text_file_analyzer.rb
# 功能：分析文本文件内容并提供基础统计信息

require 'fileutils'
require 'openssl'

class TextFileAnalyzer
  # 构造器
  def initialize(file_path)
    @file_path = file_path
  end

  # 分析文件内容并返回统计信息
  def analyze
    return { error: 'File not found' } unless File.exist?(@file_path)
    return { error: 'File is empty' } unless File.size(@file_path) > 0

    file_content = File.read(@file_path)
    stats = {
      words: word_count(file_content),
      characters: character_count(file_content),
      line_count: line_count(file_content),
      file_hash: file_hash(file_content)
    }
    stats
  rescue => e
    { error: e.message }
  end

  private

  # 计算单词数量
  def word_count(content)
    content.scan(/\b\w+\b/).size
  end

  # 计算字符数量
  def character_count(content)
    content.chars.size
  end

  # 计算行数
  def line_count(content)
    content.count("
") + 1
  end

  # 计算文件内容的哈希值
  def file_hash(content)
    OpenSSL::Digest::SHA256.hexdigest(content)
  end
end

# 使用示例
if __FILE__ == $0
  analyzer = TextFileAnalyzer.new(ARGV[0])
  result = analyzer.analyze
  puts result unless result.is_a?(Hash) && result.key?(:error)
  puts result[:error] if result.is_a?(Hash) && result.key?(:error)
end