# 代码生成时间: 2025-09-10 09:42:33
# ZipExtractorService is a class responsible for extracting zip files.
class ZipExtractorService
  # Initializes a new ZipExtractorService instance with a source zip file path and destination directory path.
  # @param source_zip_path [String] the path to the zip file to be extracted.
  # @param destination_dir [String] the directory where the extracted files will be placed.
  def initialize(source_zip_path, destination_dir)
    @source_zip_path = source_zip_path
    @destination_dir = destination_dir
  end

  # Extracts the zip file to the destination directory.
  # @return [Boolean] true if extraction is successful, false otherwise.
  def extract
    return false unless File.exist?(@source_zip_path)
    return false unless File.directory?(@destination_dir)

    begin
      # Use the rubyzip library to extract the zip file.
      Zip::File.open(@source_zip_path) do |zip_file|
        zip_file.each do |entry|
          # Create the directory structure if it does not exist.
          FileUtils.mkdir_p(File.join(@destination_dir, File.dirname(entry.name))) unless File.exist?(File.join(@destination_dir, File.dirname(entry.name)))

          # Extract each file.
          entry.extract(File.join(@destination_dir, entry.name))
        end
      end
      true
    rescue Zip::Error => e
      # Handle any zip related errors.
      puts "An error occurred while extracting the zip file: #{e.message}"
      false
    rescue StandardError => e
      # Handle any other standard errors.
      puts "An unexpected error occurred: #{e.message}"
      false
    end
  end
end

# Usage example:
# extractor = ZipExtractorService.new('/path/to/source.zip', '/path/to/destination')
# if extractor.extract
#   puts 'Extraction successful'
# else
#   puts 'Extraction failed'
# end