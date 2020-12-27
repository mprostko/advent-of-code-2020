data = File.read('day15.input').split(',').map(&:to_i)

round = 0
while(data.size < 2020)
  idx = data.each_index.select { |x| data[x] == data.last }
  a = idx.size > 1 ? idx[-1] : 0
  b = idx.size > 1 ? idx[-2] : 0
  data << a - b
  round += 1
end

puts data.last

data = File.read('day15.input').split(',').map(&:to_i)
round = data.size - 1
last_1 = data[0..-2].each_with_index.inject({}) { |obj, (number, index)| obj[number] = index + 1; obj }
last_2 = {}
while(data.size < 30_000_000)
  number = data.last
  round += 1
  unless last_1[number]
    last_1[number] = round  
    data << 0
    next
  end
  last_2[number] = last_1[number]
  last_1[number] = round
  data << last_1[number] - last_2[number]
end

puts data.last
