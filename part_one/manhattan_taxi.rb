class ManhattanTaxi
  NAVIAGATION = {
    "N" => { "L" => "W", "R" => "E" },
    "E" => { "L" => "N", "R" => "S" },
    "S" => { "L" => "E", "R" => "W" },
    "W" => { "L" => "S", "R" => "N" }
  }.freeze

  def initialize(directions:)
    @directions        = directions
    @location          = { x: 0, y: 0 }
    @current_direction = "N"
  end

  def travel!
    directions.each do |direction|
      turn             = direction[0]
      number_of_blocks = direction[/\d+/].to_i

      navigate_turn!(turn)
      navigate_blocks!(number_of_blocks)
    end
  end

  def distance_from_start
    location[:x].abs + location[:y].abs
  end

  private

  attr_reader :directions, :location
  attr_accessor :current_direction

  def navigate_turn!(turn)
    self.current_direction = NAVIAGATION[current_direction][turn]
  end

  def navigate_blocks!(number_of_blocks)
    case current_direction
    when "N"
      location[:y] = location[:y] + number_of_blocks
    when "E"
      location[:x] = location[:x] + number_of_blocks
    when "S"
      location[:y] = location[:y] - number_of_blocks
    when "W"
      location[:x] = location[:x] - number_of_blocks
    end
  end
end
