# 代码生成时间: 2025-09-14 11:45:53
# theme_switcher.rb
# This Ruby on Rails controller handles theme switching functionality.

class ThemeController < ApplicationController
  # POST /theme/switch
  def switch
    # Retrieve the selected theme from the request parameters
    theme_name = params[:theme]

    # Validate the theme name to prevent invalid or malicious input
    unless Theme.available_themes.include?(theme_name)
      render json: { error: "Invalid theme selected" }, status: :bad_request
      return
    end

    # Store the selected theme in the session for this user
    session[:theme] = theme_name

    # Render a success response with the selected theme
    render json: { message: "Theme switched successfully", selected_theme: theme_name }
  end

  private

  # Class method to define the available themes
  def self.available_themes
    %w[light dark]
  end
end