class Circle
  def initialize(radius)
    @radius = radius
  end

  def >(other)
    area > other.area
  end

  protected

  def area
    Math::PI * (radius * radius)
  end

  attr_reader :radius
end

circle_a = Circle.new(5)
circle_b = Circle.new(4)

p circle_a > circle_b # true
p circle_a.area     # a NoMethodError should occur here
p circle_a.radius   # a NoMethodError should occur here