# 代码生成时间: 2025-08-21 14:36:39
# error_logger.rb
# This module is designed to collect and log errors in a Ruby on Rails application.

module ErrorLogger
  # Logs the error to the specified file or standard output.
  def self.log_error(error_message, file_path = 'error.log')
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    error_entry = "[#{timestamp}] ERROR: #{error_message}
"
    File.open(file_path, 'a') { |f| f.puts error_entry }
  rescue IOError => e
    log_error("Failed to write error to log file: #{e.message}")
  end
end

# Usage example:
# ErrorLogger.log_error("Something went wrong")
# ErrorLogger.log_error("Database connection failed", "db_error.log")
