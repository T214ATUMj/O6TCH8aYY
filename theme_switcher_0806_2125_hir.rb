# 代码生成时间: 2025-08-06 21:25:03
# ThemeSwitcherController.rb
# This controller handles theme switching functionality within a Rails application.

class ThemeSwitcherController < ApplicationController
  # POST /theme_switcher/switch
  def switch
    # Ensure the theme is valid
    theme = params[:theme]
    if Theme::VALID_THEMES.include?(theme)
      # Save the theme preference to the user's session
      session[:theme] = theme
      render json: { message: "Theme switched to #{theme} successfully." }
    else
      # Handle invalid theme error
      render json: { error: "Invalid theme provided." }, status: :bad_request
    end
  end
end

# Theme module
# Defines the valid themes for the application.
module Theme
  # List of valid themes
  VALID_THEMES = %w[light dark]
end