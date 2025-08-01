# 代码生成时间: 2025-08-01 12:15:51
# theme_switcher.rb
# This Ruby on Rails controller handles theme switching functionality.

class ThemesController < ApplicationController
  # POST /themes/switch
  # Switches the application theme based on the provided theme name.
  def switch
    # Check if the request is a POST request
    unless request.post?
      render plain: 'Invalid request method', status: :method_not_allowed
      return
    end

    # Extract the theme name from the request parameters
    theme_name = params[:theme]&.strip
    if theme_name.blank?
      # If theme name is missing or empty, respond with a bad request
      render plain: 'Theme name is required.', status: :bad_request
      return
    end

    # Validate the theme name against a list of allowed themes
    unless valid_theme?(theme_name)
      # If the theme is invalid, respond with a bad request
      render plain: 'Invalid theme.', status: :bad_request
      return
    end

    # Set the theme in the user's session
    session[:theme] = theme_name

    # Redirect back to the previous page or a default location
    redirect_to :back, notice: "Theme switched to #{theme_name}"
  rescue StandardError => e
    # Handle any unexpected errors and respond with an internal server error
    render plain: "An error occurred: #{e.message}", status: :internal_server_error
  end

  private

  # Checks if the given theme is in the list of valid themes.
  # This method should be updated with the actual list of themes available in the application.
  def valid_theme?(theme)
    %w[light dark].include?(theme) # Example themes: 'light' and 'dark'
  end
end