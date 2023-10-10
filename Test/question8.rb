class Foo
  attr_accessor :bar
  attr_writer :qux
  attr_reader :baz

  def initialize(bar, qux)
    @bar = bar
    self.qux = qux
  end
end

foo = Foo.new(1, 2)

p foo.bar # => 1
foo.bar = 2
p foo.bar # => 2
p foo.baz # => nil
foo.baz = 3 # NoMethodError
p foo.qux # NoMethodError