# 代码生成时间: 2025-08-26 22:21:01
# Restful API Example using Ruby on Rails
# This code demonstrates a simple RESTful API in Rails

# app/controllers/api/v1/posts_controller.rb
class Api::V1::PostsController < ApplicationController
  # GET /posts
  def index
    @posts = Post.all
    render json: @posts
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    if @post
      render json: @post
    else
      render json: { error: 'Post not found' }, status: :not_found
    end
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: { message: 'Post deleted successfully' }, status: :ok
  end

  private
    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end

# app/models/post.rb
class Post < ApplicationRecord
  # This is a simple model for demonstration.
  # In a real-world application, you would include validations,
  # associations, and other model logic.
end

# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end
end