class Movement
  attr_reader :direction
  def initialize(direction)
    @direction = direction
  end

  def turn
    direction[0]
  end

  def number_of_blocks
    direction[/\d+/].to_i
  end
end
