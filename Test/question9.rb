class Car
  attr_accessor :speed

  def initialize(speed)
    @speed = speed
  end

  def accelerate
    new_speed = speed + 10
    @speed = new_speed
  end

  def faster_than?(other_car)
    speed > other_car.speed
  end
end

car1 = Car.new(40)
car2 = Car.new(40)
car1.accelerate
p car1.faster_than?(car2)