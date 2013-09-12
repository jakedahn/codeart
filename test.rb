
def setup
  size(500, 545, P3D)
  fill(0, 0, 0, 0)
end

def draw    
  # binding.pry
  # background 100    
  1.upto(10).each do |i|
    w = Wat.new(width, height)
    w.draw()
  end
end

class Wat
  def initialize(width, height)
    @x = random(width)
    @y = random(height)
    @width = random(width)
    @height = random(height)
  end

  def draw
    rect(@x, @y, @width, @height)
  end

end
