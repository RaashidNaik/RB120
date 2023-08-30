class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name #=> 42
puts fluffy #=> My name is 42
puts fluffy.name #=> 42
puts name #=> 43

=begin
The `name` variable on line 13 is initialized and assigned to the integer 42. 
On line 14, the fluffy object is initialized and uses the 42 integer as an
argument.
On line 4, the number 42 is converted to a string with the `to_s` method and
then assigned to the @name variable, meaning that the fluffy object has an
instance variable @name = "42".

On line 15, name += 1, will convert the name = 42 to name = 43.  This will have
no effect on the @name instance variable because the initialization step has
occurred already. 

On line 16, we are utitlizing the name getter method under `attr_reader :name`, 
which will output the @name instance variable for fluffy, which is "42". 
Therefore, the `puts` method on this line will output "42"

On line 17, the `puts` method's `to_s` method is overridden on line 8 to line 9
since the `Pet` class has a new method defined for `to_s`. Therefore, the output
will take the @name instance variable of "42" and upcase it, which results in
the same string "42". Therefore teh output of line 17 will be "My name is 42"

Line 18, will be the exact same output as line 16: "42"

Line 19, is referencing the variable assigned on line 13, which was incremented
by 1 on line 15 and re-assigned to the name variable.  The puts method, will
then output "43"

=end