# Given the following classes, implement the necessary methods to get the expected output.

class DataBase
  attr_reader :things

  def initialize
    @things = []
  end

  def <<(student)
    things.each do |existing_student|
      if student == existing_student
        return "That student is already in the database"
      end
    end
    things << student
  end

  def show_things
    things.each do |student|
      puts "A #{student.class}: #{student.name}"
    end
  end
end

class Student
  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id = id
  end

  def ==(other)
    name == other.name && id == other.id
  end
end

jill1 = Student.new('Jill', 12345)
jill2 = Student.new('Jill', 67890)
jill3 = Student.new('Jill', 12345)

p jill1 == jill2              # false
p jill1 == jill3              # true

kids = DataBase.new

kids << jill1
kids << jill2
kids << jill3               # => That student is already in the database

kids.show_things
  # => A Student: Jill
  # => A Student: Jill