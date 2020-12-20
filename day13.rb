timestamp, buses = File.read('day13.input').split("\n")
timestamp = timestamp.to_i
buses = buses.split(',').reject { |x| x == 'x' }.map(&:to_i)
puts buses.map{ |id| [id, id - (timestamp % id)] }.min_by{ |x| x[1] }.inject(:*)

def e_gcd(a,b)
  return 1,0 if b == 0
  q,r = a.divmod(b)
  s,t = e_gcd(b,r)
  return t, s-q*t
end

data = File.read('day13.input').split("\n").last.split(',')
data = data.map.with_index { |item, index| 
  item.eql?('x') ? nil : [item.to_i, item.to_i-index]
}.reject { |x| x.nil? }

def ctr(data)
  bn = data.map{ |n,r| n }.inject(:*)
  val = data.map do |n,r|
    bni = bn / n
    mi = e_gcd(bni, n)
    r * bni * mi[0]
  end
  val.sum % bn
end
 
puts ctr(data)
