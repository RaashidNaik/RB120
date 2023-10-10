=begin
Write 3 methods inside the Person class and one method in the Friend class
that would return the outputs shown on lines 23 and 24.
=end

class Person
  attr_reader :friends

  def initialize
    @friends = []
  end

  def <<(friend)
    friends.push(friend)
  end

  def []=(idx, friend)
    friends[idx] = friend
  end

  def [](idx)
    friends[idx]
  end
end

class Friend
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end
end

tom = Person.new
john = Friend.new('John')
amber = Friend.new('Amber')

tom << amber
tom[1] = john
puts tom[0]      # => Amber
puts tom.friends # => ["Amber", "John"]