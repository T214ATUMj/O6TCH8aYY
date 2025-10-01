# 代码生成时间: 2025-10-02 03:57:26
# human_resources_management.rb
# This Ruby on Rails application provides basic human resource management functionality.

# To run this application, include it within a Rails project and ensure that the necessary
# gems and database configurations are set up.

# Ensure you have the following gems in your Gemfile:
# gem 'activerecord', '~> 7.0'
# gem 'bcrypt', '~> 3.1'

# Load the necessary Rails modules
require 'active_record'
require 'bcrypt'

# Define the Employee model
class Employee < ActiveRecord::Base
  # Include BCrypt for secure password hashing
  has_secure_password

  # Validations for the Employee model
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :department, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  # Relationships
  has_many :timesheets
end

# Define the Timesheet model
class Timesheet < ActiveRecord::Base
  belongs_to :employee

  # Validations for the Timesheet model
  validates :employee, presence: true
  validates :hours_worked, numericality: { only_integer: true, greater_than: 0 }
  validates :date, presence: true
end

# Define a controller for employee management
class EmployeesController < ApplicationController
  # GET /employees
  def index
    @employees = Employee.all
    render json: @employees
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: @employee, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # GET /employees/:id
  def show
    @employee = Employee.find(params[:id])
    render json: @employee
  end

  # PUT /employees/:id
  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employees/:id
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    render json: { notice: 'Employee was successfully destroyed.' }
  end

  private
    def employee_params
      params.require(:employee).permit(:name, :email, :role, :department, :password)
    end
end

# Define a controller for timesheet management
class TimesheetsController < ApplicationController
  # GET /employees/:employee_id/timesheets
  def index
    @employee = Employee.find(params[:employee_id])
    @timesheets = @employee.timesheets
    render json: @timesheets
  end

  # POST /employees/:employee_id/timesheets
  def create
    @employee = Employee.find(params[:employee_id])
    @timesheet = @employee.timesheets.build(timesheet_params)
    if @timesheet.save
      render json: @timesheet, status: :created, location: [@employee, @timesheet]
    else
      render json: @timesheet.errors, status: :unprocessable_entity
    end
  end

  private
    def timesheet_params
      params.require(:timesheet).permit(:hours_worked, :date)
    end
end

# Define routes for the application
Rails.application.routes.draw do
  resources :employees do
    resources :timesheets
  end
end

# Additional documentation and instructions should be provided in the README file
# and within the application's wiki or documentation section.
