# 代码生成时间: 2025-08-13 03:52:17
# 使用RUBY和RAILS框架创建RESTful API接口

# 确保先安装Rails和必要的gem
# gem install rails

# 创建一个新的Rails项目
# rails new restful_api_project

# 进入项目目录
# cd restful_api_project

# 创建一个新的资源模型
# rails generate model Resource name:string description:text

# 运行数据库迁移
# rails db:migrate

# 开启Rails服务器
# rails server

# app/controllers/resources_controller.rb
class ResourcesController < ApplicationController
  # 获取所有资源
  def index
    @resources = Resource.all
    render json: @resources
  end

  # 创建新的资源
  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      render json: @resource, status: :created
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  # 获取单个资源
  def show
    @resource = Resource.find(params[:id])
    render json: @resource
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Resource not found' }, status: :not_found
  end

  # 更新资源
  def update
    @resource = Resource.find(params[:id])
    if @resource.update(resource_params)
      render json: @resource
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  # 删除资源
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    render json: { message: 'Resource destroyed' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Resource not found' }, status: :not_found
  end

  private
  # 强参数方法
  def resource_params
    params.require(:resource).permit(:name, :description)
  end
end

# config/routes.rb
Rails.application.routes.draw do
  resources :resources
end

# db/migrate/xxxx_create_resources.rb
class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :name
      t.text :description
    end
  end
end

# app/models/resource.rb
class Resource < ApplicationRecord
end