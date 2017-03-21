require_relative "../manhattan_taxi"
require "test/unit"

class ManhattanTaxiTest < Test::Unit::TestCase
  def test_directions_example_one
    directions = %w(R2 L3)
    taxi = ManhattanTaxi.new(directions: directions)
    taxi.travel!

    assert_equal(5, taxi.distance_from_start)
  end

  def test_directions_example_two
    directions = %w(R2 R2 R2)
    taxi = ManhattanTaxi.new(directions: directions)
    taxi.travel!

    assert_equal(2, taxi.distance_from_start)
  end

  def test_directions_example_three
    directions = %w(R5 L5 R5 R3)
    taxi = ManhattanTaxi.new(directions: directions) 
    taxi.travel!

    assert_equal(12, taxi.distance_from_start)
  end

  def test_distance_to_headquarters_example_one
    directions = %w(R8 R4 R4 R8)
    taxi = ManhattanTaxi.new(directions: directions)
    taxi.travel!

    assert_equal(4, taxi.distance_to_headquarters)
  end
end
