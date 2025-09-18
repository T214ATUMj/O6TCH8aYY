# 代码生成时间: 2025-09-19 04:02:10
# app/models/article.rb
# 这是我们的Article模型，用于防止SQL注入

class Article < ApplicationRecord
  # 使用ActiveRecord的参数化查询来防止SQL注入
  def self.find_by_title(title)
    # 使用参数化查询来确保安全
    where("title = ?", title).first
  end

  # 添加一个新方法来防止SQL注入
  def self.find_or_initialize_by_title(title)
    # 尝试找到标题匹配的文章，如果没有找到则初始化一个新对象
    find_by_title(title) || new(title: title)
  end

  # 错误处理，确保在查找过程中出现的问题能够被捕获
  def self.safe_find_by_title(title)
    begin
      find_by_title(title)
    rescue ActiveRecord::PreparedStatementCacheExpired
      # 处理PreparedStatementCacheExpired异常，这可能由SQL注入引起
      nil
    rescue StandardError => e
      # 处理其他标准错误
      Rails.logger.error "Error finding article: #{e.message}"
      nil
    end
  end
end

# app/controllers/articles_controller.rb
# 控制器中的代码，用于处理文章的查找

class ArticlesController < ApplicationController
  # 显示文章的action
  def show
    # 从参数中获取title，并使用安全的方法查找文章
    @article = Article.safe_find_by_title(params[:id])
    # 如果文章不存在，则返回404错误
    unless @article
      render file: 'public/404.html', status: :not_found
    end
  end
end