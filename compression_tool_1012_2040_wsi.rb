# 代码生成时间: 2025-10-12 20:40:44
# compression_tool.rb
# A simple Ruby/Rails application for data compression and decompression

require 'zlib'
require 'active_support/all'

class CompressionTool
  # Compresses the given data using gzip
  def compress(data)
    return Zlib::Deflate.deflate(data)
  end

  # Decompresses the given data using gzip
  def decompress(data)
    begin
      return Zlib::Inflate.inflate(data)
    rescue Zlib::DataError => e
      puts "Error: #{e.message}"
      return nil
    end
  end

  # Helper method to display usage information
  def self.usage
    puts "Usage:
    compression_tool.rb compress <input_file> <output_file>
    compression_tool.rb decompress <input_file> <output_file>"
  end

  # Main method to parse command-line arguments and execute the corresponding action
  def self.main(args)
    if args.empty? || args.size != 4
      usage
      return
    end

    tool = CompressionTool.new
    case args[1]
    when 'compress'
      input_file = args[2]
      output_file = args[3]
      File.open(input_file, 'rb') do |file|
        data = file.read
        compressed_data = tool.compress(data)
        File.open(output_file, 'wb') do |file|
          file.write(compressed_data)
        end
      end
    when 'decompress'
      input_file = args[2]
      output_file = args[3]
      File.open(input_file, 'rb') do |file|
        data = file.read
        decompressed_data = tool.decompress(data)
        if decompressed_data
          File.open(output_file, 'wb') do |file|
            file.write(decompressed_data)
          end
        end
      end
    else
      puts "Error: Unknown command '#{args[1]}'"
      usage
    end
  end
end

# Run the main method if the script is executed directly
if __FILE__ == $0
  CompressionTool.main(ARGV)
end