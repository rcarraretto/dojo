def solve(minemap, miner, exit)
  EscapeTheMine.new(minemap, miner, exit).directions
end

class EscapeTheMine
  def initialize(minemap, miner, exit)
    minemap = minemap.transpose
    exit = Location.from_coordinates(exit)
    map = Minemap.new(minemap, exit)
    path = MinePath.new(map)
    @exploration = MineExploration.new(path)
    @miner_location = Location.from_coordinates(miner)
  end

  def directions
    directions = @exploration.explore(@miner_location)
    return false if not directions
    directions
  end
end

class MineExploration
  def initialize(path)
    @path = path
  end

  def explore(location)
    unless @path.should_explore?(location)
      return false
    end

    @path.go_to(location)

    unless @path.reached_exit?
      explore_remainder_locations
    end

    unless @path.reached_exit?
      @path.step_back
      return false
    end

    @path.directions
  end

  def explore_remainder_locations
    @path.neighbors.find { |neighbor| explore(neighbor) }
  end
end

class MinePath
  def initialize(map)
    @map = map
    @visited = []
  end

  def should_explore?(location)
    @map.valid?(location) && unexplored?(location)
  end

  def unexplored?(location)
    @visited.include?(location) == false
  end

  def go_to(location)
    @location = location
    @visited << location
  end

  def reached_exit?
    @map.exit?(@location)
  end

  def neighbors
    @location.neighbors
  end

  def step_back
    @visited.pop
  end

  def directions
    Location.directions(@visited)
  end
end

class Location
  attr_reader :row, :col

  def initialize(row, col)
    @row = row
    @col = col
  end

  def self.from_coordinates(c)
    Location.new(c['y'], c['x'])
  end

  def neighbors
    Location.direction_names.map { |direction| send(direction) }
  end

  def self.direction_names
    ['left', 'right', 'up', 'down']
  end

  def left
    self + Location.new(0, -1)
  end

  def right
    self + Location.new(0, 1)
  end

  def up
    self + Location.new(-1, 0)
  end

  def down
    self + Location.new(1, 0)
  end

  def +(other)
    Location.new(@row + other.row, @col + other.col)
  end

  def self.directions(locations)
    locations
      .each_cons(2)
      .map { |location_pair| direction(location_pair) }
  end

  def self.direction(location_pair)
    before = location_pair.first
    after = location_pair.last
    direction_names.find { |direction| after == before.send(direction) }
  end

  def ==(other)
    @row == other.row && @col == other.col
  end
end

class Minemap
  def initialize(minemap, exit)
    @minemap = minemap
    @exit = exit
  end

  def valid?(location)
    inside_the_mine?(location) && open?(location)
  end

  def inside_the_mine?(location)
    0 <= location.row && location.row < @minemap.length &&
      0 <= location.col
  end

  def open?(location)
    @minemap[location.row][location.col]
  end

  def exit?(location)
    location == @exit
  end
end
