data = File.read('day6.input')

count = data.split("\n\n").map do |group|
  grp = group.gsub("\n", '').split('').uniq.size
end.sum

puts count

count = data.split("\n\n").map do |group|
  group.split("\n").map { |x| x.split('') }.reduce(:&).count
end.sum

puts count
