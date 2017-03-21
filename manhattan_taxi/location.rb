class Location
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(location)
    x == location.x && y == location.y
  end
end
