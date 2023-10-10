module Swimmable
  def swim
    "I'm swimming!"
  end
end

module WagTail
  def wagtail
    "I'm wagging my tail to express my happiness"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable         # mixing in Swimmable module
end

class Mammal < Animal
  def warmblood
    "I'm using my warm blood to cool myself"
  end
end

class Cat < Mammal
  include WagTail           # mixing in WagTail module
end

class Dog < Mammal
  include Swimmable         # mixing in Swimmable module
  include WagTail           # mixing in WagTail module
end

class Bear < Mammal
end
