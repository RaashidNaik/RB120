class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def name=(new_name)
    @name = new_name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

kitty.name = 'Luna'
kitty.greet