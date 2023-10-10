class Cat
  attr_accessor :name

  def set_name
    @name = "Cheetos"
  end
end

cat = Cat.new
cat.set_name
p cat.name