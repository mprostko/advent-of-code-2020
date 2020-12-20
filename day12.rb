require 'pry'
class Ship
  attr_reader :x, :y, :absolute
  BEARINGS = { 'N' => 0, 'W' => 1, 'S' => 2, 'E' => 3 }

  def initialize(x=0, y=0, absolute=true)
    @facing = 'E'
    @x = 0
    @y = 0
    @wpx = x
    @wpy = y
    @absolute = absolute
  end

  def run(cmd, arg)
    case cmd
    when 'N', 'S', 'E', 'W'
      if absolute
        move(cmd, arg)
      else
        move_waypoint(cmd, arg)
      end
    when 'L', 'R'
      if absolute
        rotate(cmd, arg)
      else
        rotate_relative(cmd, arg)
      end
    when 'F'
      if absolute
        move(@facing, arg)
      else
        move_relative(@facing, arg)
      end
    end
  end

  def move_waypoint(bearing, arg)
    case bearing
    when 'N'
      @wpy += arg
    when 'S'
      @wpy -= arg
    when 'E'
      @wpx += arg
    when 'W'
      @wpx -= arg
    end
  end

  def move_relative(bearing, arg)
    @x += @wpx * arg
    @y += @wpy * arg
  end

  def rotate_relative(cmd, arg)
    degrees = cmd == 'L' ? arg : -arg
    theta = degrees * Math::PI / 180
    dx = (Math.cos(theta) * @wpx - Math.sin(theta) * @wpy).round
    dy = (Math.sin(theta) * @wpx + Math.cos(theta) * @wpy).round
    @wpx = dx
    @wpy = dy
  end

  def move(bearing, arg)
    case bearing
    when 'N'
      @y += arg
    when 'S'
      @y -= arg
    when 'E'
      @x += arg
    when 'W'
      @x -= arg
    end
  end

  def rotate(cmd, arg)
    current = BEARINGS[@facing]
    steps = arg / 90
    @facing = case cmd
              when 'L'
                BEARINGS.key((current + steps) % 4)
              when 'R'
                BEARINGS.key((current - steps) % 4)
              end
  end

  def position
    [x,y, @wpx, @wpy]
  end

  def manhattan
    x.abs + y.abs
  end
end

ship = Ship.new

map = File.read('day12.input').split("\n").each do |line|
  cmd,arg = line.scan(/(.)(.*)/).flatten
  ship.run(cmd, arg.to_i)
end

puts ship.manhattan


ship = Ship.new(10, 1, false)

map = File.read('day12.input').split("\n").each do |line|
  cmd,arg = line.scan(/(.)(.*)/).flatten
  ship.run(cmd, arg.to_i)
end

puts ship.manhattan

