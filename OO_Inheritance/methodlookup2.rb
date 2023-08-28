class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

=begin
The lookup path is as follows
Cat > Animal > Object > Kernel > BasicObject  and then we get an undefined
method error. 
=end