require 'minitest/autorun'
require_relative 'temp_spread'

class TempSpreadTest < Minitest::Test
  attr_reader :obj

  def setup
    @obj = TempSpread.new('./weather.dat', 0, 13, 'MxT', 'MnT')
  end

  def test_initial_state_of_attributes
    assert obj.loaded_file
    assert_empty obj.headers
    assert_empty obj.spreads
  end

  def test_single_day_spreads
    obj.determine_min_spread_day # to populate everything
    refute_empty obj.headers
    refute_empty obj.spreads

    assert_equal 29, obj.spreads["1"]["Spread"]
    assert_equal 16, obj.spreads["2"]["Spread"]
  end

  def test_min_spread
    assert_equal '14', obj.determine_min_spread_day
  end
end
