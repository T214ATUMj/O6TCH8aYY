# 代码生成时间: 2025-08-14 19:34:23
# 表单数据验证器
#
# 此Ruby脚本实现了一个简单的表单数据验证器，遵循Rails框架的最佳实践。
# 它包含错误处理和必要的注释，确保代码的可维护性和可扩展性。

class FormValidator
  # 初始化方法，接收表单数据
  def initialize(data)
    @data = data
  end

  # 验证表单数据的方法
  # @return [Boolean] 表单数据是否有效
  def validate
    # 检查所有字段是否不为空
    if @data.all? { |key, value| !value.empty? }
      # 检查邮箱格式是否正确
      if valid_email?(@data['email'])
        true
      else
        add_error('Email format is invalid.')
        false
      end
    else
      add_error('All fields must be filled out.')
      false
    end
  end

  # 添加错误信息的方法
  # @param [String] message 错误信息
  def add_error(message)
    @errors ||= []
    @errors << message
  end

  # 获取所有错误信息的方法
  # @return [Array<String>] 所有错误信息
  def errors
    @errors || []
  end

  # 检查邮箱格式是否正确的私有方法
  # @param [String] email 待检查的邮箱地址
  # @return [Boolean] 邮箱格式是否正确
  private
  def valid_email?(email)
    return false unless email

    # 使用正则表达式匹配邮箱格式
    pattern = /\A[^@]+@[^@]+\z/
    pattern.match?(email)
  end
end

# 示例用法
if __FILE__ == $0
  data = {
    name: 'John Doe',
    email: 'john@example.com',
    age: '30'
  }
  validator = FormValidator.new(data)
  if validator.validate
    puts 'Form data is valid.'
  else
    puts 'Form data is invalid.'
    puts 'Errors:'
    validator.errors.each { |error| puts error }
  end
end
