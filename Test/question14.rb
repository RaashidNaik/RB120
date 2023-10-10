class Student
  attr_reader :name, :grade
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def ==(other)
    name == other.name && grade == other.grade
  end
end

bob1 = Student.new('Bob', 12)
bob2 = Student.new('Bob', 12)
puts bob1 == bob2             # => false