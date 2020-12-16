def adjacent(x, y, map, search_limit)
  x_min = 0
  y_min = 0
  x_max = map[0].size - 1
  y_max = map.size - 1
  diag = Proc.new { |x_off, y_off|
    ret = 0
    xx = x.dup + x_off
    yy = y.dup + y_off
    while(xx.between?(x_min,x_max) && yy.between?(y_min,y_max)) do
      case map[yy][xx]
      when '#'
        ret = 1
        break
      when 'L'
        break
      end      
      break if search_limit
      xx += x_off
      yy += y_off
    end
    ret
  }
  tl = diag.call(-1, -1)
  t  = diag.call( 0, -1)
  tr = diag.call(+1, -1)
  cl = diag.call(-1,  0)
  cr = diag.call(+1, +0)
  bl = diag.call(-1, +1)
  b  = diag.call( 0, +1)
  br = diag.call(+1, +1)

  tl + t + tr + cl + cr + bl + b + br
end

# return true if changed, false if not
def fill(map, search_limit, occupied_limit)
  new_map = []
  map.each_with_index do |row, y|
    new_row = []
    row.each_with_index do |seat, x|
      new_row <<  case seat
                  when 'L' # empty, occupy if no adjacent are
                    adjacent(x,y,map,search_limit) == 0 ? '#' : seat
                  when '#' # occupied, empty if >= occupied_limit adjacent are taken
                    adjacent(x,y,map,search_limit) >= occupied_limit ? 'L' : seat
                  else 
                    '.'
                  end
    end
    new_map << new_row
  end
  new_map
end

def draw(map)
  map.each { |row| puts row.join('') }
  puts
end

map = File.read('day11.input').split("\n").map { |x| x.split('') }
while(true)
  #draw(map)
  new_map = fill(map, true, 4)
  break if map.map{ |x| x.join }.join == new_map.map{ |x| x.join }.join
  map = new_map
end
puts map.map{ |x| x.join }.join.count('#')

map = File.read('day11.input').split("\n").map { |x| x.split('') }
while(true)
  #draw(map)
  new_map = fill(map, false, 5)
  break if map.map{ |x| x.join }.join == new_map.map{ |x| x.join }.join
  map = new_map
end
puts map.map{ |x| x.join }.join.count('#')
