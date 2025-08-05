# 代码生成时间: 2025-08-05 08:07:28
# integration_test_tool.rb
#
# This Ruby script is an example of an integration test tool
# using the Rails framework. It demonstrates how to structure
# tests, handle errors, and document the code following Ruby best practices.
#

require 'rails'
require 'rspec/rails'
require 'capybara/rails'
require 'database_cleaner'
require 'factory_bot_rails'

# RSpec configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Use FactoryBot for creating test data
  config.include FactoryBot::Syntax::Methods

  # Use DatabaseCleaner to clean the database between tests
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  
  config.around(:each) do |example|
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
    example.run
    DatabaseCleaner.clean
  end

  config.fail_fast = ENV['FAIL_FAST'] || false
  config.use_transactional_fixtures = false
end

# Example integration test
RSpec.describe 'Integration Test Example', type: :request do
  # FactoryBot factory for creating test users
  let(:user) { FactoryBot.create(:user) }

  # Test to check user login functionality
  it 'logs in a user successfully' do
    # Navigate to the login page and enter credentials
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    # Expect to be redirected to the dashboard and see a welcome message
    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_content('Welcome, ' + user.name)
  rescue StandardError => e
    puts 'An error occurred during the test: ' + e.message
  end
end
