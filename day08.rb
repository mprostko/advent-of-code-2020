data = []
File.readlines('day8.input').each do |line|
  cmd, arg = line.scan(/([a-z]+) ([\+\-0-9]+)/).flatten
  data << { cmd: cmd, arg: arg.to_i}
end

class Computer
  attr_reader :acc

  def initialize(program)
    @acc = 0
    @pc = 0
    @program = program
  end

  def run
    while(@pc < @program.size) do
      cmd, arg = @program[@pc].values
      old_pc = @pc.dup
      
      case cmd
      when 'nop'
        @pc += 1
      when 'jmp'
        @pc += arg
      when 'acc'
        @acc += arg
        @pc += 1
      when 'raise'
        return -@acc
      end
      @program[old_pc] = { cmd: 'raise', arg: nil }
    end
    return @acc
  end
end

def dup_data(data)
  data.each_with_object([]) { |d, arr| arr << d.dup }
end

puts Computer.new(dup_data(data)).run

jmps = data.each_index.select { |index| data[index][:cmd] == 'jmp' }
nops = data.each_index.select { |index| data[index][:cmd] == 'nop' }

combinations = []

jmps.each do |index|
  new_data = dup_data(data)
  new_data[index][:cmd] = 'nop'
  combinations << new_data
end

nops.each do |index|
  new_data = dup_data(data.dup)
  new_data[index][:cmd] = 'jmp'
  combinations << new_data
end

combinations.each do |program|
  r = Computer.new(program).run
  puts r if r > 0
end

