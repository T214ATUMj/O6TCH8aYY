# 代码生成时间: 2025-09-02 03:35:56
# math_toolbox_controller.rb

# 控制器负责处理数学计算工具集的请求
class MathToolboxController < ApplicationController

  # 计算两个数的加法
  def add
    # 从请求中获取参数
    num1 = params[:num1].to_f
    num2 = params[:num2].to_f

    # 检查参数是否有效
    if num1.nan? || num2.nan?
      render json: { error: 'Invalid input' }
      return
    end

    # 执行加法运算
    sum = num1 + num2

    # 返回结果
    render json: { sum: sum }
  end

  # 计算两个数的减法
  def subtract
    num1 = params[:num1].to_f
    num2 = params[:num2].to_f

    if num1.nan? || num2.nan?
      render json: { error: 'Invalid input' }
      return
    end

    difference = num1 - num2
    render json: { difference: difference }
  end

  # 计算两个数的乘法
  def multiply
    num1 = params[:num1].to_f
    num2 = params[:num2].to_f

    if num1.nan? || num2.nan?
      render json: { error: 'Invalid input' }
      return
    end

    product = num1 * num2
    render json: { product: product }
  end

  # 计算两个数的除法
  def divide
    num1 = params[:num1].to_f
    num2 = params[:num2].to_f

    if num1.nan? || num2.nan? || num2 == 0
      render json: { error: 'Invalid input' }
      return
    end

    quotient = num1 / num2
    render json: { quotient: quotient }
  end

end