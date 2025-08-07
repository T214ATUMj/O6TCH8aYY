# 代码生成时间: 2025-08-07 19:48:23
# interactive_chart_generator.rb
# This Ruby on Rails program is an interactive chart generator.
# It allows users to input data and generate charts based on that data.

require 'rails'
require 'chartkick'
require 'highcharts'

class ChartGenerator
  # Initializes the chart generator with a title and data array
  def initialize(title, data)
    @title = title
    @data = data
  end

  # Generates a line chart from the input data
  def generate_line_chart
    return render_chart('line', @data)
  end

  # Generates a bar chart from the input data
  def generate_bar_chart
    return render_chart('bar', @data)
  end

  private

  # Renders a chart using Chartkick and Highcharts
  def render_chart(type, data)
    begin
      # Check if data is empty
      raise 'Data cannot be empty' if data.empty?

      # Create a new chart object
      chart = Chartkick::Chart.new('chart', data, {
        type: type,
        title: {
          text: @title
        }
      })

      # Render the chart to HTML
      highcharts = Highcharts::HighChart.new('chart') do |c|
        c.chart(type: type, options: { zoomType: 'x' })
        c.title(text: @title)
        c.series(data)
      end

      # Return the rendered chart HTML
      return highcharts.to_html.html_safe
    rescue => e
      # Handle any errors that occur during chart generation
      return "Error: #{e.message}"
    end
  end
end

# Usage Example:
# data = [["January", 40], ["February", 80], ["March", 100], ["April", 140]]
# chart_generator = ChartGenerator.new("Monthly Sales", data)
# line_chart_html = chart_generator.generate_line_chart
# puts line_chart_html
# bar_chart_html = chart_generator.generate_bar_chart
# puts bar_chart_html