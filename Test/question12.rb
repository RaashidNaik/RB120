class Person
  attr_accessor :name, :weight, :height

  @@total_people = 0

  def initialize(name, weight, height)
    @name = name
    @weight = weight
    @height = height
    @@total_people += 1
  end

  def self.total_people
    @@total_people
  end

  def change_info(name, weight, height)
    self.name = name
    self.weight = weight
    self.height = height
  end
end

bob = Person.new('bob', 185, 70)
Person.total_people       # this should return 1

class Person
  puts self #=> Person

  def i_am_an_instance_method
    "I am an instance method"
  end
end