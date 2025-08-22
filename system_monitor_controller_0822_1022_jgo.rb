# 代码生成时间: 2025-08-22 10:22:38
# SystemMonitorController.rb
# This controller is responsible for monitoring system performance metrics.

class SystemMonitorController < ApplicationController
  # GET /system_monitor
  def index
    # Fetch system performance metrics such as CPU, Memory, and Disk usage.
    begin
      cpu_usage = `top -bn1 | grep load | awk '{printf "%.2f
", $(NF-4)}'`.to_f
      memory_usage = `free -m | awk 'NR==2{printf "%.2f
", $3/$2 * 100.0 }'`.to_f
      disk_usage = `df -h | grep / | awk '{print $5}' | sed 's/%//'`.to_f
      
      # Respond with system performance data in JSON format.
      render json: {
        :cpu_usage => cpu_usage,
        :memory_usage => memory_usage,
        :disk_usage => disk_usage
      }
    rescue => e
      # Handle any errors that occur during the fetching of system metrics.
      render json: {
        :error => 'Failed to fetch system performance metrics.',
        :message => e.message
      }, status: :internal_server_error
    end
  end
end