require 'minitest/autorun'
require_relative 'goal_spread'

class GoalSpreadTest < Minitest::Test
  attr_reader :obj

  def setup
    @obj = GoalSpread.new('./football.dat', 7, 51, 'F', 'A')
  end

  def test_initial_state_of_attributes
    assert obj.loaded_file
    assert_equal [], obj.headers
    assert obj.spreads == {}
  end

  def test_single_day_spreads
    obj.calculate_min_spread # to populate everything
    refute_equal [], obj.headers
    refute_empty obj.spreads

    assert_equal 43, obj.spreads["Arsenal"]["Spread"]
    assert_equal 37, obj.spreads["Liverpool"]["Spread"]
  end

  def test_max_spread
    assert_equal 'AstonVilla', obj.calculate_min_spread
  end
end
