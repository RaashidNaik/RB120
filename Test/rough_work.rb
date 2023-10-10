class Employee
  attr_reader :name, :serial_no, :vacation_days, :desk

  def initialize(name, serial_no, vacation_days, desk)
    @name = name
    @serial_no = serial_no
  end

  def to_s
    puts "Name: #{name}"
    puts "Type: #{self.class}"
    puts "Serial number: #{serial_no}"
    puts "Vacation days: #{vacation_days}"
    puts "Desk #{desk}"
  end
end

class Executives < Managers
  def initialize(name, serial_no)
    super
    @vacation_days = 20
    @desk = "corner office"
  end
end

class Managers < RegularEmployees
  def initialize(name, serial_no)
    super(name, serial_no, 14, "corner_office")
    @vacation_days = 14
    @desk = "corner office"
  end

  def hire
  end

  def fire
  end

  def delegate
  end
end

class RegularEmployees < Employee
  def initialize(name, serial_no)
    super
    @vacation_days = 10
    @desk = "cubicle"
  end

  def take_vacation
    @vacation_days -= 1
  end
end

class PartTimeEmployees < Employee
  def initialize(name, serial_no)
    super
    @vacation_days = 0
    @desk = " opne "
end
