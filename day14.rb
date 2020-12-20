blocks = File.read('day14.input').split("mask = ").reject{|x| x.empty?}

mem = {}
def write(mem, addr, value, mask)
  m = mask.split('').reverse.map.with_index{ |x, index| x.eql?('X') ? nil : [x.to_i, index] }
  m.reject!{ |x| x.nil? }
  m.each do |bit, position|
    if !bit.zero?
      value |=  (1 << position)
    else
      value &= ~(1 << position)
    end
  end
  mem[addr] = value
end

blocks.each do |block|
  block = block.split("\n")
  mask = block[0]
  block[1..-1].each do |change|
    addr, val = change.scan(/mem\[([0-9]+)\] = ([0-9]+)/).first
    write(mem, addr.to_i, val.to_i, mask)
  end
end

puts mem.values.sum

blocks = File.read('day14.input').split("mask = ").reject{|x| x.empty?}
mem = {}

def write(mem, addr, value, mask)
  addr = addr.dup.to_s(2).rjust(36, '0')
  mask.split('').each_with_index do |bit, index| 
    if bit == '1'
      addr[index] = '1'
    end
  end
  addresses = [addr]

  mask.split('').each_with_index do |item, index|
    if item == 'X'
      addresses.map! do |ad|
        a = ad.dup; a[index] = '0';
        b = ad.dup; b[index] = '1'; 
        [a,b]
      end.flatten!
    else
      next
    end
  end

  addresses.uniq.each { |ad| mem[ad] = value }
end

blocks.each do |block|
  block = block.split("\n")
  mask = block[0]
  block[1..-1].each do |change|
    addr, val = change.scan(/mem\[([0-9]+)\] = ([0-9]+)/).first
    write(mem, addr.to_i, val.to_i, mask)
  end
end

puts mem.values.sum