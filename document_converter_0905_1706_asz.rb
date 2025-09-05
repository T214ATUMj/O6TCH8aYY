# 代码生成时间: 2025-09-05 17:06:47
# Document Converter
#
# This Ruby on Rails application provides a simple document format converter.
# It can be expanded to support more formats in the future.

require 'roo'
require 'roo-xls'
require 'roo-excelx'
require 'json'

class DocumentConverter
  # Initializes a new DocumentConverter instance.
  #
  # @param input_file_path [String] the path to the input file to convert.
  # @param output_file_path [String] the path to save the converted file.
  # @param format [String] the format to convert to.
  def initialize(input_file_path, output_file_path, format)
    @input_file_path = input_file_path
    @output_file_path = output_file_path
    @format = format
  end

  # Converts the document to the specified format and saves it to the output file path.
  #
  # @return [Boolean] true if the conversion was successful, false otherwise.
  def convert
    begin
      case @format
      when 'csv'
        convert_to_csv
      when 'json'
        convert_to_json
      else
        raise 'Unsupported format'
      end
    rescue StandardError => e
      puts "Error converting document: #{e.message}"
      false
    end
  end

  private

  # Converts the input file to CSV format and saves it to the output file path.
  def convert_to_csv
    @excel = Roo::Spreadsheet.open(@input_file_path)
    csv_string = @excel.to_csv
    File.write(@output_file_path, csv_string)
  end

  # Converts the input file to JSON format and saves it to the output file path.
  def convert_to_json
    @excel = Roo::Spreadsheet.open(@input_file_path)
    json_string = @excel.to_json
    File.write(@output_file_path, json_string)
  end
end

# Example usage:
# converter = DocumentConverter.new('path/to/input.xlsx', 'path/to/output.csv', 'csv')
# converter.convert
