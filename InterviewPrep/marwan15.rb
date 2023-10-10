class Foo
  @@var = 1

  def self.var
    @@var
  end
end

class Bar < Foo
  @@var = 2
end

puts Foo.var #=> 1
puts Bar.var #=> 2

=begin
You got this wrong.  The answer should both be 2.  The problem is that class
variables are shared among the subclass and superclass.  You cannot change
a class variable in a subclass without affecting the superclass.
=end