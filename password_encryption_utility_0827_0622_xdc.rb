# 代码生成时间: 2025-08-27 06:22:31
# PasswordEncryptionUtility.rb
# This utility provides functions for password encryption and decryption.

require 'openssl'
require 'base64'

class PasswordEncryptionUtility
  # Encrypts a password with a given key.
  #
  # @param plain_text_password [String] The password to encrypt.
  # @param encryption_key [String] The key to use for encryption.
  # @return [String] The encrypted password in Base64.
  def self.encrypt(plain_text_password, encryption_key)
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.encrypt
    cipher.key = encryption_key
    cipher.iv = cipher.random_iv

    # Encrypt the password
    encrypted_password = cipher.update(plain_text_password) + cipher.final

    # Encode the result in Base64
    Base64.strict_encode64(encrypted_password)
  end

  # Decrypts a password given the encrypted password and the key.
  #
  # @param encrypted_password_base64 [String] The encrypted password in Base64.
  # @param encryption_key [String] The key used to encrypt the password.
  # @return [String] The decrypted password.
  def self.decrypt(encrypted_password_base64, encryption_key)
    encrypted_password = Base64.decode64(encrypted_password_base64)
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.decrypt
    cipher.key = encryption_key
    cipher.iv = encrypted_password[0...16] # Assumes the IV is the first 16 bytes

    # Decrypt the password
    decrypted_password = cipher.update(encrypted_password) + cipher.final
    decrypted_password.force_encoding('UTF-8')
  rescue OpenSSL::Cipher::CipherError
    raise 'Decryption failed. Please check the provided encryption key.'
  end

  # Generates a secure encryption key.
  #
  # @return [String] A secure random key suitable for encryption.
  def self.generate_key
    OpenSSL::Random.random_bytes(32)
  end
end
