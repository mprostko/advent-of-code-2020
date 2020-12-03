data = []
File.readlines('day3.input').each do |line|
  data << line.split('')
end

def trees(data, x_step = 3, y_step = 1)
  line_size = data.first.length
  x = 0
  count = 0
  data.each_with_index do |line, index|
    next if index.zero?
    next unless index % y_step == 0
    x = (x + x_step) % (line_size - 1)
    count += 1 if line[x].eql?('#')
  end
  count
end

puts trees(data, 3, 1)

puts trees(data, 1, 1) * trees(data, 3, 1) * trees(data, 5, 1) * trees(data, 7, 1) * trees(data, 1, 2)
