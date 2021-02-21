require 'pry'

class NodeList
	attr_reader :list

	def initialize
		@list = []
	end

	def add(x,y,z,active=true)
		@list << Node.new(x,y,z,active)
	end

	def neighbours(location)
		[-1,0,1].repeated_permutation(3).to_a.map do |loc|
			n_loc = [
								loc[0]+location[0],
							 	loc[1]+location[1],
							 	loc[2]+location[2]
							]
			next if n_loc == location
			find(n_loc) || Node.new(n_loc[0], n_loc[1], n_loc[2], false)
		end.compact!
	end

	def find(location)
		@list.find { |x| x.location == location }
	end

	def display
		x = (minmax[0][0])..(minmax[0][1])
		y = (minmax[1][0])..(minmax[1][1])
		z = (minmax[2][0])..(minmax[2][1])

		z.each do |zi|
			puts "Z=#{zi}"
			y.each do |yi|
				x.each do |xi|
					node = find([xi,yi,zi])
					print (node.nil? ? '.' : '#')
				end
				puts ''
			end
		end
	end

	def compute
		# Expand field by 1 in each direction
		x = (minmax[0][0]-1)..(minmax[0][1]+1)
		y = (minmax[1][0]-1)..(minmax[1][1]+1)
		z = (minmax[2][0]-1)..(minmax[2][1]+1)
		new_list = []

		z.each do |zi|
			y.each do |yi|
				x.each do |xi|
					node = find([xi, yi, zi]) || Node.new(xi, yi, zi, false)
					n = neighbours([xi,yi,zi])
					active_n = n.select{ |x| x.active? }.count

					if node.active?
							new_list << [xi,yi,zi] if (2..3).cover?(active_n)
					else
						new_list << [xi,yi,zi] if active_n == 3
					end
				end
			end
		end
		
		@list = []
		new_list.each do |loc|
			add(loc[0],loc[1],loc[2],true)
		end
	end

	def minmax
		@list.map { |x| x.location }.transpose.map { |x| x.minmax }
	end
end
 
class Node
	attr_reader :x, :y, :z

	def initialize(x=0,y=0,z=0,active=false)
		@x = x
		@y = y
		@z = z
		@active = active
	end 

	def active?
		@active
	end 

	def inactive?
		!@active
	end 

	def location
		[@x,@y,@z]
	end
end

list = NodeList.new

File.read('day17.input').split("\n").each_with_index do |line, y|
	line.split('').each_with_index do |char, x|
		list.add(x.to_i, y.to_i, 0, true) if char == '#'
	end
end

#binding.pry

6.times do 
	list.compute
end
puts list.list.count