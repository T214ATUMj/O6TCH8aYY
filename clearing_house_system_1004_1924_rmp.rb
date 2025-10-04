# 代码生成时间: 2025-10-04 19:24:47
# ClearingHouseSystem.rb
# A simple Ruby on Rails application that simulates a clearinghouse system
# for financial transactions.

require 'active_record'
require 'active_support'
require 'active_support/core_ext'

# Define a Transaction model to represent the transactions
class Transaction < ActiveRecord::Base
  # Associations
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :sender_id, :receiver_id, presence: true

  # Before create, check if sender has enough balance to send the transaction
  before_create :check_balance

  private

  # Check if sender has enough balance to send the transaction
  def check_balance
    unless sender.balance >= amount
      errors.add(:amount, 'Insufficient balance')
      throw(:abort)
    end
  end
end

# Define a User model to represent the users
class User < ActiveRecord::Base
  # Associations
  has_many :sent_transactions, class_name: 'Transaction', foreign_key: :sender_id
  has_many :received_transactions, class_name: 'Transaction', foreign_key: :receiver_id

  # Validations
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, uniqueness: true

  # Callbacks
  after_create :initialize_balance

  # Initialize the balance for a new user
  def initialize_balance
    self.balance = 0
    save(validate: false)
  end
end

# Define a clearinghouse system class
class ClearingHouseSystem
  # Method to process transactions
  def process_transactions(transactions)
    transactions.each do |transaction|
      begin
        transaction.save!
        # Update balances after successful transaction
        sender = User.find(transaction.sender_id)
        receiver = User.find(transaction.receiver_id)
        sender.update(balance: sender.balance - transaction.amount)
        receiver.update(balance: receiver.balance + transaction.amount)
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
        puts "Error processing transaction: #{e.message}"
      end
    end
  end
end

# Usage example
if __FILE__ == $0
  # Initialize the clearinghouse system
  clearing_house = ClearingHouseSystem.new

  # Create users
  alice = User.create!(name: 'Alice', balance: 1000)
  bob = User.create!(name: 'Bob', balance: 500)

  # Create transactions
  transactions = [
    Transaction.new(sender_id: alice.id, receiver_id: bob.id, amount: 200),
    Transaction.new(sender_id: bob.id, receiver_id: alice.id, amount: 50)
  ]

  # Process transactions
  clearing_house.process_transactions(transactions)
end