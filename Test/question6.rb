module Swimmable
  def swim
    "swimming!"
  end
end

class Dog
  include Swimmable
  # ... rest of class omitted
end

class Fish
  include Swimmable
  # ... rest of class omitted
end

module People
  class PoliceOfficer
  end

  class FireMan
  end

  class Accountant
  end

end

module Animals
  class Dog
  end

  class Cat
  end

  class Alligator
  end
end


module People
  NUMBER_OF_LEGS = 2

  class PoliceOfficer
  end

  class FireMan
  end

  class Accountant
  end
end

module Animals
  NUMBER_OF_LEGS = 4

  class Dog
  end

  class Cat
  end

  class Alligator
  end
end

module Miscelleneous
  def some_random_method
    "I am a random method that shouldn't be associated with a class"
  end

  def yet_another_random_method
    "I too am a random method that shouldn't be associated with a class"
  end
end

