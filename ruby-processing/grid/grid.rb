
def setup
  size(660, 520)
  fill(0, 0, 0, 0)
end

def draw
  img = load_image("#{File.expand_path(File.dirname(__FILE__))}/bg.jpg")
  background(img);  

  g = Grid.new(10, width, height)
  g.draw_intersections

end

class Grid
  attr_accessor :width, :height, :grid_size, :virt_lines, :horiz_lines, :verticies
  def initialize(grid_size_px, width, height)
    @width = width
    @height = height
    @grid_size = grid_size_px
    @virt_lines = []
    @horiz_lines = []
    @verticies = nil


    println('width: %s' % @width)
    println('height: %s' % @height)
    println('grid_size: %s' % @grid_size)
  end

  def get_grid_lines
    if @virt_lines.empty? and @horiz_lines.empty?
      (0..@width).each_with_index do |pixel, idx|
        if (pixel % @grid_size) == 0
          # println('x pixel %s' % pixel)
          @virt_lines.push(pixel)
        end
      end
      (0..@height).each_with_index do |pixel, idx|
        if (pixel % @grid_size) == 0
          # println('y pixel %s' % pixel)
          @horiz_lines.push(pixel)
        end
      end
    end
  end

  def draw_grid
    get_grid_lines
    println('x items: %s' % @virt_lines.length)
    println('y items: %s' % @horiz_lines.length)

    if @virt_lines and @horiz_lines
      @virt_lines.each do |x|
        line(x, 0, x, @height)
        stroke(126)
      end
      @horiz_lines.each do |y|
        line(0, y, @width, y)
        stroke(126)
      end
    else      
      draw_grid
    end
  end

  def gather_verticies
    if @verticies.nil?
      get_grid_lines
      verticies = []
      @virt_lines.each do |virt_pixel|
        @horiz_lines.each do |horiz_pixel|
          verticies.push({:x => virt_pixel, :y => horiz_pixel})
        end
      end
    end
    @verticies = verticies
  end

  def draw_intersections
    gather_verticies

    @verticies.each do |point|
      b = Box.new(point[:x], point[:y], @grid_size)
      b.draw
    end
  end

end

class Box
  attr_accessor :x, :y, :opacity
  def initialize(x, y, size)
    @x = x
    @y = y
    @size = size
    @opacity = 100
  end

  def draw
    fill(255, 255, 255, random(100))
    stroke(255, 255, 255, 10)
    rect(x, y, @size, @size)
  end

end

