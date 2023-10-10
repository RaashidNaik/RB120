class Student
  def initialize(id, name)
    @id = id
    @name = name
  end

  def ==(other)
    self.id == other.id
  end

  protected

  attr_reader :id, :name
end

rob = Student.new(123, "Rob")
tom = Student.new(456, "Tom")

p rob == tom