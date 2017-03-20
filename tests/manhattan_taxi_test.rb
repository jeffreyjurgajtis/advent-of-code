require_relative "../manhattan_taxi"
require "test/unit"

class ManhattanTaxiTest < Test::Unit::TestCase
  def test_directions_example_one
    directions = %w(R2 L3)
    taxi = ManhattanTaxi.new(directions: directions)
    taxi.travel!

    assert_equal(taxi.distance_from_start, 5)
  end

  def test_directions_example_two
    directions = %w(R2 R2 R2)
    taxi = ManhattanTaxi.new(directions: directions)
    taxi.travel!

    assert_equal(taxi.distance_from_start, 2)
  end

  def test_directions_example_three
    directions = %w(R5 L5 R5 R3)
    taxi = ManhattanTaxi.new(directions: directions) 
    taxi.travel!

    assert_equal(taxi.distance_from_start, 12)
  end
end
