# 代码生成时间: 2025-09-20 06:11:35
# security_audit_log.rb
#
# This file is responsible for auditing security logs in a Rails application.
# It includes error handling, documentation, and adherence to Ruby best practices.

require 'logger'

# Custom logger module that extends the standard Ruby Logger class.
module SecurityAuditLogger
  class Logger < ::Logger
    # Custom formatter for the logger to include severity, timestamp, and message.
    class Formatter < ::Logger::Formatter
      def call(severity, time, _progname, msg)
        "#{time.strftime('%Y-%m-%d %H:%M:%S')} [#{severity}] #{msg}
"
      end
    end
  end
end

# Initial setup for the security audit log.
class SecurityAuditLog
  # Initialize the logger with a custom formatter.
  def initialize(log_path)
    @logger = SecurityAuditLogger::Logger.new(log_path)
    @logger.formatter = SecurityAuditLogger::Logger::Formatter.new
  end

  # Log a security event with severity level.
  def log_event(event, severity)
    # Check if the event is a valid string.
    unless event.is_a?(String)
      raise ArgumentError, 'Event must be a string'
    end

    # Check if the severity is valid.
    unless [:info, :warn, :error, :fatal].include?(severity)
      raise ArgumentError, 'Invalid severity level'
    end

    # Log the event with the specified severity.
    @logger.add(severity, event)
  rescue => e
    # Handle any exceptions that occur during logging.
    @logger.add(:fatal, "Failed to log event: #{e.message}")
  end

  # Close the logger.
  def close
    @logger.close
  end
end

# Example usage of the SecurityAuditLog class.
# This should be placed in an appropriate part of the application where security events are logged.
begin
  audit_log = SecurityAuditLog.new('path/to/audit_log.log')
  audit_log.log_event('User logged in', :info)
rescue ArgumentError => e
  puts "Logging error: #{e.message}"
ensure
  audit_log.close if audit_log
end