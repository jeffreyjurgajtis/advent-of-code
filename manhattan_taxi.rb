class ManhattanTaxi
  class Movement
    attr_reader :direction
    def initialize(direction:)
      @direction = direction
    end

    def turn
      direction[0]
    end

    def number_of_blocks
      direction[/\d+/].to_i
    end
  end

  NAVIAGATION = {
    "N" => { "L" => "W", "R" => "E" },
    "E" => { "L" => "N", "R" => "S" },
    "S" => { "L" => "E", "R" => "W" },
    "W" => { "L" => "S", "R" => "N" }
  }.freeze

  def initialize(directions:)
    @movements         = directions.map { |d| Movement.new(direction: d) }
    @current_location  = { x: 0, y: 0 }
    @current_direction = "N"
    @visited_locations = []
  end

  def travel!
    movements.each do |movement|
      self.previous_location = current_location
      navigate_turn!(movement.turn)
      navigate_blocks!(movement.number_of_blocks)
    end
  end

  def distance_from_start
    manhattan_distance(current_location)
  end

  def distance_to_headquarters
    manhattan_distance(location_of_headquarters)
  end

  private

  attr_reader :movements, :visited_locations
  attr_accessor :current_direction, :current_location, :previous_location

  def navigate_turn!(turn)
    self.current_direction = NAVIAGATION[current_direction][turn]
  end

  def navigate_blocks!(number_of_blocks)
    case current_direction
    when "N"
      travel_north(number_of_blocks)
    when "E"
      travel_east(number_of_blocks)
    when "S"
      travel_south(number_of_blocks)
    when "W"
      travel_west(number_of_blocks)
    end

    self.current_location = visited_locations.last
  end

  def travel_north(number_of_blocks)
    destination = previous_location[:y] + number_of_blocks
    y = previous_location[:y] + 1

    while y <= destination
      visited_locations << { x: previous_location[:x], y: y }
      y += 1
    end
  end

  def travel_east(number_of_blocks)
    destination = previous_location[:x] + number_of_blocks
    x = previous_location[:x] + 1

    while x <= destination
      visited_locations << { x: x, y: previous_location[:y] }
      x += 1
    end
  end

  def travel_south(number_of_blocks)
    destination = previous_location[:y] - number_of_blocks
    y = previous_location[:y] - 1

    while y >= destination
      visited_locations << { x: previous_location[:x], y: y }
      y -= 1
    end
  end

  def travel_west(number_of_blocks)
    destination = previous_location[:x] - number_of_blocks
    x = previous_location[:x] - 1

    while x >= destination
      visited_locations << { x: x, y: previous_location[:y] }
      x -= 1
    end
  end

  def location_of_headquarters
    visited_locations.detect do |location|
      visited_locations.rindex(location) != visited_locations.index(location)
    end
  end

  def manhattan_distance(location)
    location[:x].abs + location[:y].abs
  end
end
