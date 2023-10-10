=begin
#13a — What will be returned by the value1 and value2 method calls?
#13b — If we omit the first line (VAL = ‘Global’), what will the returned values be then?
#13c — Without defining VAL again, what line of code can you add to the Bar class inside the
Foo module to allow value2 access to the same VAL as value1?
=end

# VAL = 'Global'

module Foo
  VAL = 'Local'

  class Bar
    def value1
      VAL
    end
  end
end

class Foo::Bar
  def value2
    VAL
  end
end

p Foo::Bar.new.value1 #=> 'Local'
p Foo::Bar.new.value2 #=> 'Global'