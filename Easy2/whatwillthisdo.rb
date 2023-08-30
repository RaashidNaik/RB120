class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata


=begin
On line 15, the `thing` variable is assigned to a new object from the `Something`
class with @data instance variable being assigned to `Hello`

On line 16, we are outputting the `dupdata` class method (self.dupdata), which
should output the string 'ByeBye'

On line 17, we are invoking the `dupdata` on the instance thing, which will 
take the @data, which is 'Hello' and output 'HelloHello'

Thus the output will be:
ByeBye
HelloHello

=end
