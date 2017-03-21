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
      self.previous_location = current_location.clone
      navigate_turn!(movement.turn)
      navigate_blocks!(movement.number_of_blocks)

      record_visited_locations!
    end
  end

  def distance_from_start
    manhattan_distance(current_location)
  end

  def distance_to_headquarters
    manhattan_distance(location_of_headquarters)
  end

  private

  attr_reader :movements, :current_location, :visited_locations
  attr_accessor :current_direction, :previous_location

  def navigate_turn!(turn)
    self.current_direction = NAVIAGATION[current_direction][turn]
  end

  def navigate_blocks!(number_of_blocks)
    case current_direction
    when "N"
      current_location[:y] = current_location[:y] + number_of_blocks
    when "E"
      current_location[:x] = current_location[:x] + number_of_blocks
    when "S"
      current_location[:y] = current_location[:y] - number_of_blocks
    when "W"
      current_location[:x] = current_location[:x] - number_of_blocks
    end
  end

  def record_visited_locations!
    point_1 = previous_location
    point_2 = current_location

    case current_direction
    when "N"
      y = point_1[:y] + 1

      while y <= point_2[:y]
        visited_locations << { x: point_1[:x], y: y }
        y += 1
      end
    when "E"
      x = point_1[:x] + 1

      while x <= point_2[:x]
        visited_locations << { x: x, y: point_1[:y] }
        x += 1
      end
    when "S"
      y = point_1[:y] - 1

      while y >= point_2[:y]
        visited_locations << { x: point_1[:x], y: y }
        y -= 1
      end
    when "W"
      x = point_1[:x] - 1

      while x >= point_2[:x]
        visited_locations << { x: x, y: point_1[:y] }
        x -= 1
      end
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
