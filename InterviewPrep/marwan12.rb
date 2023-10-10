module Walk
  STR = "Walking"
end

module Run
  STR = "Running"
end

module Jump
  STR = "Jumping"
end

class Bunny
  include Jump
  include Walk
  include Run
end

class Bugs < Bunny; end

p Bugs.ancestors #=> Bugs>Bunny>Run>Walk>Jump>Object>Kernel>BasicObject
p Bugs::STR #=> "Running"