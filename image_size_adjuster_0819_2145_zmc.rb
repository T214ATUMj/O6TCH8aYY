# 代码生成时间: 2025-08-19 21:45:14
# 图片尺寸批量调整器
class ImageSizeAdjuster
  # 初始化方法，设置目标文件夹和输出文件夹
  def initialize(input_folder, output_folder, target_size)
    @input_folder = input_folder
    @output_folder = output_folder
    @target_size = target_size
  end

  # 调整图片尺寸的方法
  def adjust_image_sizes
    Dir.glob(File.join(@input_folder, '*')).each do |file_path|
      begin
        image = MiniMagick::Image.open(file_path)
        image.resize(@target_size)
        image.write(File.join(@output_folder, File.basename(file_path)))
      rescue MiniMagick::Error => e
        puts "Error resizing image #{File.basename(file_path)}: #{e.message}"
      end
    end
  end

  # 获取目标文件夹中的所有图片文件
  private
  def get_image_files
    Dir.glob(File.join(@input_folder, '*.jpg')) # 可根据需要扩展支持更多格式
  end
end

# 使用示例
# adjuster = ImageSizeAdjuster.new('path/to/input', 'path/to/output', '300x300>')
# adjuster.adjust_image_sizes
