# 代码生成时间: 2025-09-29 00:01:51
# leaderboard.rb
# This Ruby program is designed to simulate a leaderboard functionality.

# Define a class to represent a leaderboard
class Leaderboard
  attr_reader :scores

  # Initialize a new leaderboard with an empty list of scores
  def initialize
    @scores = []
  end

  # Add a score to the leaderboard
  # @param score [Hash] with keys :player and :points
  def add_score(score)
    return "Score must be a hash with :player and :points" unless score.is_a?(Hash) && score.has_key?(:player) && score.has_key?(:points)
    return "Player must be a string" unless score[:player].is_a?(String)
    return "Points must be an integer" unless score[:points].is_a?(Integer)
    @scores << score
    @scores.sort_by! { |s| s[:points] }.reverse!
  end

  # Get the top N scores from the leaderboard
  # @param n [Integer] the number of top scores to retrieve
  def top_scores(n)
    return "Number must be a positive integer" unless n.is_a?(Integer) && n > 0
    @scores.first(n)
  end
end

# Example usage:
# leaderboard = Leaderboard.new
# leaderboard.add_score({ player: 'Alice', points: 100 })
# leaderboard.add_score({ player: 'Bob', points: 50 })
# leaderboard.add_score({ player: 'Charlie', points: 120 })
# puts leaderboard.top_scores(2).inspect