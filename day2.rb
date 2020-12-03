data = []
File.readlines('day2.input').each do |line|
  data << line.scan(/(\d+)-(\d+) ([a-z]): ([a-z]+)/)
end

p1 = data.select do |pw|
  min, max, char, pass = *pw.flatten
  pass.count(char).between?(min.to_i, max.to_i)
end

puts p1.count

p2 = data.select do |pw|
  p_a, p_b, char, pass = *pw.flatten
  pass[p_a.to_i - 1].eql?(char) ^ pass[p_b.to_i - 1].eql?(char)
end

puts p2.count
