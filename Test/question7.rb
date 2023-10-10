class Person
  def initialize(name)
    @name = name  # Assigning the name argument to the @name instance variable
    age = 23      # Creating local variable age that is not an instance variable
  end

  def display_name
    @name         # Calling the instance variable outside of the method it was initialized in with no errors
  end

  def display_age
    age           # Calling the local variable outside of the method it was initialized in causing an error.
  end
end

raashid = Person.new("Raashid")
puts raashid.display_name #=> Raashid
# puts raashid.display_age  #=> NameError

raashid = Person.new("Raashid")
steve = Person.new("Steve")

puts raashid.display_name #=> Raashid
puts steve.display_name #=> Steve