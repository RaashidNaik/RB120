class Book
  
  # attr_reader :author, :title
  def title 
    @title
  end

  def author
    @author
  end
  
  
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin
Further exploration:
You could also use the attr_accessor method because it has the same functionality
as the attr_reader method, but also contains the attr_writer method as well. 

We could not just solely use the attr_writer method because the `book.title`, 
`book.author` instance method invocations requirer a getter method to obtain
the instance variables and attr_writer is a setter method. 

You can replace attr_reader :author, :title with the following and the output
would be the same: 

def title 
  @title
end

def author
  @author
end

=end