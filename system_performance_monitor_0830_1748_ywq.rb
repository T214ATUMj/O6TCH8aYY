# 代码生成时间: 2025-08-30 17:48:05
# This is a simple system performance monitor tool written in Ruby.
# It collects basic system information such as CPU usage, memory usage,
# disk usage, and network traffic.

require 'open3'
require 'json'

class SystemPerformanceMonitor
  # Initialize method
  def initialize
    # This method sets up any necessary configurations or initial states.
  end

  # Method to get CPU usage
  def cpu_usage
    # Run the command using Open3 and capture the output
    stdout, stderr, status = Open3.capture3('top -b -n 1 | grep "Cpu(s)"')
    if status.success?
      # Parse the output and return CPU usage percentage
      output = stdout.split('%Cpu(s):')[1].split(',')[1].strip
      output.split.first.to_s
    else
      raise "Failed to get CPU usage: #{stderr}
    end
  end

  # Method to get memory usage
  def memory_usage
    # Run the command to get memory usage information
    stdout, stderr, status = Open3.capture3('free -m')
    if status.success?
      # Parse the output and return memory usage in MB
      output = stdout.split(/
/)[1].split.last.split.first.to_i
      output
    else
      raise "Failed to get memory usage: #{stderr}
    end
  end

  # Method to get disk usage
  def disk_usage
    # Run the command to get disk usage information
    stdout, stderr, status = Open3.capture3('df -h')
    if status.success?
      # Parse the output and return disk usage percentage
      output = stdout.split(/
/)[1].split.last.strip
      output.split.first.to_s
    else
      raise "Failed to get disk usage: #{stderr}
    end
  end

  # Method to get network traffic
  def network_traffic
    # Run the command to get network traffic information
    stdout, stderr, status = Open3.capture3('ifconfig')
    if status.success?
      # Parse the output and return network traffic in bytes
      output = stdout.scan(/ bytes: (\d+)/).flatten.first.to_i
      output
    else
      raise "Failed to get network traffic: #{stderr}
    end
  end

  # Method to get all system performance metrics
  def get_system_metrics
    {
      "CPU Usage": cpu_usage,
      "Memory Usage": memory_usage,
      "Disk Usage": disk_usage,
      "Network Traffic": network_traffic
    }.to_json
  end
end

# Example usage:
if __FILE__ == $0
  monitor = SystemPerformanceMonitor.new
  system_metrics = monitor.get_system_metrics
  puts system_metrics
end