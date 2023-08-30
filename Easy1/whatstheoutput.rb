class Pet
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

=begin
When we initialize the variable `fluffy`, we assing the name "Fluffy" to @name
and we convert "Fluffy" to a string using the to_s method, which is redundant 
because it is already a string.

On line 16, we invoke the name getter method and use the puts method to display
the name 'Fluffy'

On line 17, because we are overriding the `to_s` for the `puts` method for the
instnace fluffy, it will execute the method in the class on line 8 to 11.  This
method mutates the "Fluffy" string to "FLUFFY" with the `upcase!` method applied
The return string will be "My name is FLUFFY"

On line 18 when we invoke the `name` method on the fluffy instance again, we
we get the mutated "FLUFFY" string

On line 19, because name is assigned to the same string object as @name in the
class, the name variable is now pointing to a mutated string object "FLUFFY". So
the `puts name` will output "FLUFFY"
=end

=begin
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
=end