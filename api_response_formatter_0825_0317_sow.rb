# 代码生成时间: 2025-08-25 03:17:51
# api_response_formatter.rb

# 此模块提供API响应格式化工具，用于将Rails应用中的响应格式化为统一的格式。
module ApiResponseFormatter
  # 格式化成功的响应
  def format_success_response(data, message: "Success", status: :ok)
    render json: {
      success: true,
      message: message,
      data: data
    }, status: status
  end

  # 格式化错误的响应
  def format_error_response(message, status: :unprocessable_entity)
    render json: {
      success: false,
      message: message
    }, status: status
  end

  # 包含响应格式化工具的控制器
  module Controller
    extend ActiveSupport::Concern

    included do
      # 在控制器中包含Helper模块
      include ApiResponseFormatter
    end
  end
  
  # 包含响应格式化工具的Helper模块
  module Helper
    include ApiResponseFormatter
  end
end

# 将ApiResponseFormatter::Controller包含到所有控制器中
class ApplicationController < ActionController::Base
  include ApiResponseFormatter::Controller
end

# 示例用法：
# 在控制器中
# def create
#   # 业务逻辑处理...
#   if @resource.save
#     format_success_response(@resource, message: "Resource created successfully", status: :created)
#   else
#     format_error_response(@resource.errors.full_messages.to_sentence)
#   end
# end