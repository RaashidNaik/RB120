class Dog
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def bark
    puts "Woof! Woof!"
  end
end

fido = Dog.new('Fido', 5)
paws = Dog.new('Paws', 3)
puts fido.name # 'Fido'
puts paws.name # 'Paws'
puts fido.age # 5
puts paws.age # 3
fido.bark # 'Woof! Woof!'
paws.bark # 'Woof! Woof!'