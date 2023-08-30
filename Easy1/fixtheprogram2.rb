class Book
  
  attr_accessor :title, :author
  
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin
Further Exploration:
By separating the initialization of instance variables and creating the object, 
we can potentially run inot issues where Book objects are created without the
instance variables being assigned, making these objects "stateless".  Without
any state these objects lack any distinguishing characteristics that the user
or program can use aside from their instance name and object_id. 
=end 