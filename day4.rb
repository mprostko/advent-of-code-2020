data = File.read('day4.input')

REQUIRED_KEYS = %w( byr iyr eyr hgt hcl ecl pid )

def valid?(hash)
  byr = hash['byr'].to_i
  return 'wrong byr' unless byr.between?(1920, 2002)
  iyr = hash['iyr'].to_i
  return 'wwrong iyr' unless iyr.between?(2010, 2020)
  eyr = hash['eyr'].to_i
  return 'wrong eyr' unless eyr.between?(2020, 2030)

  height, h_type = hash['hgt'].scan(/^([0-9]+)(cm|in)$/).flatten
  case h_type
  when 'cm'
    return 'wrong hgt' unless height.to_i.between?(150, 193)
  when 'in'
    return 'wrong hgt' unless height.to_i.between?(59, 76)
  else
    return 'wrong hgt'
  end

  return 'wrong hcl' unless hash['hcl'].scan(/^#[a-z0-9]{6}$/).any?
  return 'wrong ecl' unless %w(amb blu brn gry grn hzl oth).include?(hash['ecl'])
  return 'wrong pid' unless hash['pid'].scan(/^[0-9]{9}$/).any?
  '' 
end

count = 0
count_valid = 0
data.split(/^\n/m).each do |passport|
  data = passport.gsub("\n", ' ').split(/[ :]/).each_slice(2).to_a
  data = Hash[data]

  next unless REQUIRED_KEYS.all? { |key| data.key?(key) }
  count += 1
  count_valid += 1 if valid?(data).empty?
end

puts count
puts count_valid
