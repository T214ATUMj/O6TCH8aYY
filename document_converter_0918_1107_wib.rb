# 代码生成时间: 2025-09-18 11:07:21
# document_converter.rb

# This class is responsible for converting documents between different formats.
class DocumentConverter
  # Initialize with a source file path and a target format.
  #
  # @param source_path [String] the path to the source document.
  # @param target_format [String] the target format to convert to.
  #
  def initialize(source_path, target_format)
    @source_path = source_path
    @target_format = target_format
  end

  # Converts the document to the specified format.
  #
  # @return [String] the path to the converted document.
  #
  def convert
    # Validate the source file exists.
    unless File.exist?(@source_path)
      raise 'Source file does not exist.'
    end

    # Validate the target format is supported.
    unless supported_formats.include?(@target_format)
      raise 'Target format is not supported.'
    end

    # Perform the conversion.
    converted_path = perform_conversion
    return converted_path
  end

  private

  # List of supported formats for conversion.
  def supported_formats
    %w[pdf docx]
  end

  # Simulate the conversion process.
  def perform_conversion
    # Here you would add the actual logic to convert the document.
    # For demonstration purposes, we're just renaming the file.
    output_path = @source_path.sub(File.extname(@source_path), ".#{@target_format}")
    File.rename(@source_path, output_path)
    output_path
  end
end

# Example usage:
# converter = DocumentConverter.new('path/to/source.docx', 'pdf')
# converted_path = converter.convert
# puts "Converted file is located at: #{converted_path}"