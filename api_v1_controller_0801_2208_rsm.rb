# 代码生成时间: 2025-08-01 22:08:21
# api/v1/api_controller.rb
#
# This is a Rails controller that provides a RESTful API.
# It follows Ruby on Rails best practices to ensure
# maintainability and extensibility.

class Api::V1::ApiController < ApplicationController
  # GET /api/v1/resources
  def index
    # Fetch all resources from the database
    @resources = Resource.all
    # Handle errors if resources are not found
    respond_to do |format|
      format.json { render json: @resources, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Resource not found' }, status: :not_found
  end

  # GET /api/v1/resources/1
  def show
    # Find a single resource by id
    @resource = Resource.find(params[:id])
    # Handle errors if resource is not found
    respond_to do |format|
      format.json { render json: @resource, status: :ok }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Resource not found' }, status: :not_found
  end

  # POST /api/v1/resources
  def create
    # Create a new resource with the provided data
    @resource = Resource.new(resource_params)
    if @resource.save
      render json: @resource, status: :created
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/resources/1
  def update
    # Update an existing resource with the provided data
    @resource = Resource.find(params[:id])
    if @resource.update(resource_params)
      render json: @resource, status: :ok
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/resources/1
  def destroy
    # Delete a resource by id
    @resource = Resource.find(params[:id])
    @resource.destroy
    render json: { message: 'Resource deleted' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Resource not found' }, status: :not_found
  end

  private
    # Only allow a list of trusted parameters through
    def resource_params
      params.require(:resource).permit(:name, :description, :category)
    end
end