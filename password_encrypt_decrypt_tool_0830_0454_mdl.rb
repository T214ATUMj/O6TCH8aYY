# 代码生成时间: 2025-08-30 04:54:32
#!/usr/bin/env ruby
require 'openssl'

# PasswordEncryptDecryptTool class provides methods for encrypting and decrypting passwords
class PasswordEncryptDecryptTool
  # Encrypts a password using AES-256-CBC
  # @param password [String] the password to encrypt
  # @return [String] the encrypted password
  def self.encrypt_password(password)
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.encrypt
    # Generate a random key and iv
    key = OpenSSL::Random.random_bytes(32)
    iv = OpenSSL::Random.random_bytes(16)
    # Encrypt the password
    encrypted_password = cipher.update(password) + cipher.final
    # Return the key, iv, and encrypted password
    return Base64.strict_encode64([key, iv, encrypted_password].join)
  end

  # Decrypts a password using the AES-256-CBC algorithm
  # @param encrypted_password [String] the encrypted password to decrypt
  # @return [String] the decrypted password
  # @raise [StandardError] if the decryption fails
  def self.decrypt_password(encrypted_password)
    begin
      # Decode the encrypted password
      key, iv, encrypted_password = Base64.decode64(encrypted_password).unpack('m*')[0].split("\x00")
      # Create a cipher and decrypt the password
      cipher = OpenSSL::Cipher.new('AES-256-CBC')
      cipher.decrypt
      cipher.key = key
      cipher.iv = iv
      decrypted_password = cipher.update(encrypted_password) + cipher.final
      return decrypted_password
    rescue OpenSSL::Cipher::CipherError
      raise StandardError, 'Decryption failed'
    end
  end

  # Usage example
  # @return [void]
  def self.example_usage
    password = 'my_secret_password'
    encrypted = encrypt_password(password)
    puts "Encrypted password: #{encrypted}"

    decrypted = decrypt_password(encrypted)
    puts "Decrypted password: #{decrypted}"
  end

end

# Run the example usage
PasswordEncryptDecryptTool.example_usage