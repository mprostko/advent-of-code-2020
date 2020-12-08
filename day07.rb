vertexes = []
edges = []

def add_vertex_if_not_exists(vertexes, name)
  vertexes << name unless vertexes.include?(name)
end

def add_edge_if_not_exists(edges, a, b, count)
  edge = { a: a, b: b, weight: count.to_i }
  edges << edge unless edges.find { |x| x[:a] == edge[:a] && x[:b] == edge[:b] && x[:weight] == edge[:weight] }
end

File.readlines('day7.input').each do |line|
  vertex, connections = line.split(' bags contain ')
  add_vertex_if_not_exists(vertexes, vertex)

  connections.scan(/([0-9]) ([a-z ]+) bags?/m).each do |count, target|
    add_edge_if_not_exists(edges, vertex, target, count)
  end
end

def traverse(edges, name)
  lines = edges.select { |x| x[:b] == name}
  
  if lines.any?
    children = lines.map do |line|
      traverse(edges, line[:a])
    end.flatten
    children.concat(lines.map{|x| x[:a]})
  else
    name
  end  
end

puts traverse(edges, 'shiny gold').uniq.size

def inside(edges, name)
  lines = edges.select { |x| x[:a] == name}
 
  if lines.any?
    children = lines.map do |line|
      line[:weight] * inside(edges, line[:b])
    end

    children.sum + lines.map { |x| x[:weight] }.sum
  else
    return 0
  end  
end

puts inside(edges, 'shiny gold')
