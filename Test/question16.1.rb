=begin
Employees
@name
@serial_number
@status = part_time/full-time

Executives
@status = full_time
@vacation = 20
@office = "Corner Office"

Managers
@status = full_time
@vacation = 14
@office = "Private Office"

RegularEmployees
@status = full_time
@vacation = 10
@office = "Cubicle"

PartTimeEmployees
@status = part_time
@vacation = 0
@office = "Open Workspace"

def take_vacation # only full time employees

def delegate # only managers and executives

def hire # managers and executives

def fire # managers and executives

def to_s
Name: Dave
Type: Manager
Serial number : 123456789
Vacation days: 14
Desk: private office


=end

class Employee
  attr_reader :name, :serial_no, :vacation_days, :desk

  def initialize(name, serial_no)
    @name = name
    @serial_no = serial_no
  end

  def to_s
    "Name: #{name}" +
    "\nType: #{self.class}" +
    "\nSerial number: #{serial_no}" +
    "\nVacation days: #{vacation_days}" +
    "\nDesk: #{desk}"
  end
end

class RegularEmployee < Employee
  def initialize(name, serial_no)
    super
    @vacation_days = 10
    @desk = "cubicle"
  end

  def take_vacation
    @vacation_days -= 1
  end
end

class Manager < RegularEmployee
  def initialize(name, serial_no)
    super
    @vacation_days = 14
    @desk = "private office"
  end

  def delegate
  end
end

class Executive < Manager
  def initialize(name, serial_no)
    super
    @vacation_days = 20
    @desk = "corner office"
  end

  def hire
  end

  def fire
  end
end


class PartTimeEmployee < Employee
  def initialize(name, serial_no)
    super
    @vacation_days = 0
    @desk = "open workspace"
  end
end

executive = Executive.new("Raashid", 121212121)


puts executive
puts ""
executive.take_vacation

manager = Manager.new("Laila", 23423342)

puts manager
puts ""
manager.take_vacation

# regular  = RegularEmployee.new("Steve", 123122312)

# puts regular
# puts ""

# part_time = PartTimeEmployee.new("Carol", 23423342)

# puts part_time
# puts :""



