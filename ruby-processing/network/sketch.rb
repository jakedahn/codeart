require 'pry'
# require 'node'

NODES = []


def setup
  size(640, 480)
  fill(0, 0, 0, 0)

  range = 50
  (0..range).each do |i|
    NODES.push(Node.new(i, random(width), random(height), (0..range).to_a.sample(random(range))))
  end
end

def draw
  background(255)
  NODES.each do |n|
    n.draw_node
    n.draw_connections
  end
end


# Processing init above
#-----------------------------------------------------------------------------
# Classes below

class Node 
  attr_accessor :id, :draw_node, :x, :y, :connections

  def initialize(id, x, y, connections)
    @id = id
    @x = x
    @y = y
    @connections = connections
    @connection_count = @connections.length
    @size = @connection_count
  end

  def find_node(id)
    NODES.select{ |n| n if n.id == id }[0]
  end

  def draw_node
    fill(2,196,219, 90)
    stroke(2,196,219, 100)
    ellipse_mode(RADIUS)
    ellipse(@x, @y, @size, @size)

    fill(2,196,219, 100)
    no_stroke
    ellipse(@x, @y, 3, 3)
  end

  def draw_connections
    @connections.each do |node_id|
      connection_node = find_node(node_id)
      if connection_node.connections.include?(@id)
        stroke(0, 0, 0, 10)
        line(@x, @y, connection_node.x, connection_node.y)        
      end
    end
  end

end
