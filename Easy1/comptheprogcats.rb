class Vehicle
  
  attr_reader :make, :model, :wheels

  def initialize(make, model)
    @make = make
    @model = model
  end
  
  def to_s
    "#{make} #{model}"
  end
end


class Car < Vehicle
  def initialize
    @wheels = 4
  end
end

class Motorcycle < Vehicle
  def initialize
    @wheels = 2
  end 
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
    @wheels = 6
  end
end

truck = Truck.new("Mercedes", "M1", "Big Payload")
puts truck.wheels