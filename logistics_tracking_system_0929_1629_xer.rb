# 代码生成时间: 2025-09-29 16:29:47
# Logistics Tracking System using Ruby on Rails
# This system allows users to track packages and their statuses

require 'rails'
require 'active_record'
require 'active_support'

# Define the Package model which represents a package in the logistics system
class Package < ApplicationRecord
  # Associations
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  
  # Validations
  validates :tracking_number, presence: true, uniqueness: true
  validates :status, presence: true
  
  # Callbacks
  before_create :set_tracking_status
  
  # Scopes for querying packages
  scope :pending, -> { where(status: 'pending') }
  scope :in_transit, -> { where(status: 'in_transit') }
  scope :delivered, -> { where(status: 'delivered') }
  
  # Private method to set initial status
  private
  def set_tracking_status
    self.status = 'pending' if self.status.nil?
  end
end

# Define the User model which represents users in the logistics system
class User < ApplicationRecord
  # Associations
  has_many :sent_packages, class_name: 'Package', foreign_key: 'sender_id'
  has_many :received_packages, class_name: 'Package', foreign_key: 'recipient_id'
end

# Define a controller for package tracking
class TrackingController < ApplicationController
  # GET /tracking/:tracking_number
  def show
    @package = Package.find_by(tracking_number: params[:tracking_number])
    if @package
      render json: @package
    else
      render json: { error: 'Package not found' }, status: :not_found
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Package not found' }, status: :not_found
  rescue => e
    # Handle unexpected errors
    render json: { error: 'An unexpected error occurred' }, status: :internal_server_error
  end
end

# Define a route for package tracking
# config/routes.rb
# get 'tracking/:tracking_number', to: 'tracking#show'

# Usage examples:
# Tracking a package by its tracking number
# puts 'Tracking package...'
# package = TrackingController.new.show(tracking_number: '12345678')
# puts package
