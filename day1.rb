data = []
File.readlines('day1.input').each do |line|
  data << Integer(line)
end

p1 = data.combination(2).find do |a, b|
  a + b == 2020
end.inject(:*)

puts p1

p2 = data.combination(3).find do |a, b, c|
  a + b + c == 2020
end.inject(:*)

puts p2
