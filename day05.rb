data = []
File.readlines('day5.input').each do |line|
  data << line
end

def bp(sides, arr)
  return arr[0] if arr.size < 2
  side = sides.shift
  if side == 'F' || side == 'L'
    return bp(sides, arr[0..(arr.size/2 - 1)])
  else
    return bp(sides, arr[(arr.size/2)..-1])
  end
end

def seat_id(seat)
  seat = seat.split('')
  r = bp(seat[0..6], (0..127).to_a)
  c = bp(seat[7..-1], (0..7).to_a)
  
  r * 8 + c
end

ids = data.map{ |x| seat_id(x) }
puts ids.max

all_ids = (0..(127*8 + 8)).to_a
all_ids = all_ids[all_ids.index(ids.min)..all_ids.index(ids.max)]
puts all_ids - ids
