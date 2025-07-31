# 代码生成时间: 2025-07-31 11:49:02
# Excel表格自动生成器
class ExcelGeneratorService
  # 初始化方法
  # @param template_path [String] Excel模板文件的路径
  def initialize(template_path)
    @template_path = template_path
  end

  # 生成Excel文件
  # @param data [Array] 需要写入的数据，格式为二维数组
  # @param output_path [String] 输出文件的路径
  # @return [String] 输出文件的路径
  def generate_excel(data, output_path)
    begin
      # 加载模板文件
      template = Roo::Spreadsheet.open(@template_path)
      @workbook = template.use_first_sheet
      @worksheet = template.sheet(0)
      # 写入数据
      data.each_with_index do |row, index|
        @worksheet.add_row(row, index + 1)
      end
      # 保存文件
      template.write(output_path)
      template.close
      output_path
    rescue StandardError => e
      puts "Error generating Excel file: #{e.message}"
      nil
    end
  end
end

# 示例使用
if __FILE__ == $0
  template_path = './template.xlsx'
  output_path = './output.xlsx'
  # 假设有以下数据需要写入
  data = [["Header1", "Header2"], ["Data1", "Data2"], ["Data3", "Data4"]]

  excel_service = ExcelGeneratorService.new(template_path)
  new_file_path = excel_service.generate_excel(data, output_path)
  puts "Excel file generated at: #{new_file_path}" if new_file_path
end