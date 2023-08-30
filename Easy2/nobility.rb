module Walkable
  def walk
    puts "#{self} #{gait} forward"
  end
end

class Noble
  attr_reader :name, :title
  include Walkable
  
  def initialize(name, title)
    @name = name
    @title = title
  end
  
  def gait
    'struts'
  end
  
  def to_s
    "#{title} #{name}"
  end
end

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"