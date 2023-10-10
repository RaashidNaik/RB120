=begin
#2 — Define a class of your choice with the following:

    Constructor method that initializes 2 instance variables.
    Instance method that outputs an interpolated string of those variables.
    Getter methods for both (you can use the shorthand notation if you want).
    Prevent instances from accessing these methods outside of the class.
    Finally, explain what concept(s) you’ve just demonstrated with your code.

=end


class Person

  def initialize(name, age)
    @name = name
    @age = age
  end

  private

  attr_reader :name, :age

  def to_s
    "The object's name is #{name} and age is #{age}"
  end
end

steve = Person.new("Steve", 43)
puts steve

puts "The object information: #{steve}"
