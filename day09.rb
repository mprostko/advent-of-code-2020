data = []
File.readlines('day9.input').each do |line|
  data << line.chomp.to_i
end

preamble = data.shift(25)

err = nil
while(!data.empty?)
  num = data.shift
  unless preamble.combination(2).map { |a,b| a+b }.include?(num)
    err = num
    break
  end

  preamble.push(num)
  preamble.shift
end

puts err

data = []
File.readlines('day9.input').each do |line|
  data << line.chomp.to_i
end

sum = nil
size = 2
while(!sum)
  (0..(data.size-(size+1))).each do |start|
    line = data[start..start+size]
    if line.sum == err
      sum = line.min + line.max
      break
    end
  end
  break if sum
  size += 1
end

puts sum
