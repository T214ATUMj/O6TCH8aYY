# 代码生成时间: 2025-10-08 22:14:46
# 考勤打卡系统
# Attendance System using Ruby on Rails

# 定义考勤记录模型
class AttendanceRecord < ApplicationRecord
  # 关联员工
  belongs_to :employee
  # 记录考勤时间
  validates :check_in_time, presence: true
end

# 定义员工模型
class Employee < ApplicationRecord
  # 员工可以有多条考勤记录
  has_many :attendance_records
  # 员工姓名
  validates :name, presence: true
end

# 定义考勤系统控制器
class AttendancesController < ApplicationController
  # 考勤打卡方法
  def check_in
    # 获取员工ID和考勤时间
    employee_id = params[:employee_id]
    check_in_time = Time.current
    
    # 检查员工ID是否存在
    employee = Employee.find_by(id: employee_id)
    unless employee
      render json: { error: 'Employee not found' }, status: :not_found
      return
    end
    
    # 创建考勤记录
    attendance_record = AttendanceRecord.new(employee: employee, check_in_time: check_in_time)
    
    # 保存考勤记录
    if attendance_record.save
      render json: attendance_record
    else
      render json: { error: attendance_record.errors.full_messages }, status: :unprocessable_entity
    end
  end
end

# 路由配置
# config/routes.rb
# Rails.application.routes.draw do
#   resources :attendances, only: [:create]
# end

# 数据库迁移文件
# db/migrate/XXXXXX_create_attendance_records.rb
# class CreateAttendanceRecords < ActiveRecord::Migration[6.0]
#   def change
#     create_table :attendance_records do |t|
#       t.references :employee, null: false, foreign_key: true
#       t.datetime :check_in_time
#     end
#   end
# end

# db/migrate/XXXXXX_create_employees.rb
# class CreateEmployees < ActiveRecord::Migration[6.0]
#   def change
#     create_table :employees do |t|
#       t.string :name
#     end
#   end
# end
