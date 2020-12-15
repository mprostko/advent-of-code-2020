data = File.read('day10.input').split("\n").map(&:to_i).sort

diff = {'1' => 0, '2' => 0, '3' => 1}
data.unshift(0).each_cons(2) { |a,b| diff[(b-a).to_s] += 1 }
puts diff['1'] * diff['3']
