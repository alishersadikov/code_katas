require 'minitest/autorun'
require_relative 'kata_04_temp_spread'

class TempSpreadTest < Minitest::Test
  attr_reader :obj

  def setup
    @obj = TempSpread.new('./weather.dat')
  end

  def test_initial_state_of_attributes
    assert obj.file
    assert_equal [], obj.headers
    assert obj.spreads_by_day == {}
  end

  def test_single_day_spreads
    obj.calculate_min_spread # to populate everything
    refute_equal [], obj.headers
    refute_empty obj.spreads_by_day

    assert_equal 29, obj.spreads_by_day["1"]["Spread"]
    assert_equal 16, obj.spreads_by_day["2"]["Spread"]
  end

  def test_min_spread
    assert_equal '14', obj.calculate_min_spread
  end
end
