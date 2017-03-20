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
    @location          = { x: 0, y: 0 }
    @current_direction = "N"
  end

  def travel!
    movements.each do |movement|
      navigate_turn!(movement.turn)
      navigate_blocks!(movement.number_of_blocks)
    end
  end

  def distance_from_start
    location[:x].abs + location[:y].abs
  end

  private

  attr_reader :movements, :location
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
