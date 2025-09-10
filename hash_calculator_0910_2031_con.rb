# 代码生成时间: 2025-09-10 20:31:03
# HashCalculator class responsible for calculating hash values of strings
class HashCalculator
  # Calculate the hash value of a given string using SHA256 algorithm
  #
  # @param string [String] the string to calculate hash for
  # @return [String] the SHA256 hash value of the string
  def calculate_sha256(string)
    require 'digest'
    digest = Digest::SHA256.new
    digest.update(string)
    digest.hexdigest
  end

  # Calculate the hash value of a given string using MD5 algorithm
  #
  # @param string [String] the string to calculate hash for
  # @return [String] the MD5 hash value of the string
  def calculate_md5(string)
    require 'digest/md5'
    digest = Digest::MD5.new
    digest.update(string)
    digest.hexdigest
  end

  # Calculate the hash value of a given string using any algorithm provided
  #
  # @param string [String] the string to calculate hash for
  # @param algorithm [Symbol] the algorithm to use (e.g., :sha256, :md5)
  # @return [String] the hash value of the string in the specified algorithm
  def calculate_hash(string, algorithm)
    case algorithm
    when :sha256
      calculate_sha256(string)
    when :md5
      calculate_md5(string)
    else
      raise ArgumentError, "Unsupported algorithm: #{algorithm}"
    end
  end
end

# Example usage:
if __FILE__ == $0
  calculator = HashCalculator.new
  puts "SHA256 hash of 'hello': #{calculator.calculate_sha256('hello')}"
  puts "MD5 hash of 'hello': #{calculator.calculate_md5('hello')}"
  puts "Hash of 'hello' using unsupported algorithm: #{calculator.calculate_hash('hello', :unsupported) rescue 'Error: Unsupported algorithm'}"
end