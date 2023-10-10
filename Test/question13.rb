class Person
  puts self

  def instance_method
    "I am an instance method"
  end
end

Person #=> Person

class Person
  def self.class_method
    puts "I am a class method"
  end
end

Person.class_method #=> I am a class method

class Person
  def self.class_method
    puts "The name of this class is:"
    puts self
  end
end

Person.class_method #=> The name of this class is:
                    #=> Person