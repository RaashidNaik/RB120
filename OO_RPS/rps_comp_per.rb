require 'pry'

class Move
  attr_accessor :value
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = Rock.new if value == 'rock'
    @value = Paper.new if value == 'paper'
    @value = Scissors.new if value == 'scissors'
    @value = Lizard.new if value == 'lizard'
    @value = Spock.new if value == 'spock'
  end
  
  def >(other_move)
    self.value.beats.include?(other_move.value.name)
  end
  
  def <(other_move)
    other_move.value.beats.include?(self.value.name)
  end

  def to_s
    self.value.name
  end
end


class Rock
  attr_accessor :beats, :name
  def initialize
    @name = 'rock'
    @beats = ['scissors', 'lizard']
  end
  
  def to_s
    @name
  end
end

class Paper
  attr_accessor :beats, :name
  def initialize
    @name = 'paper'
    @beats = ['rock', 'spock']
  end
  
  def to_s
    @name
  end
end

class Scissors
  attr_accessor :beats, :name
  def initialize
    @name = 'scissors'
    @beats = ['paper', 'lizard']
  end
  
  def to_s
    @name
  end
end

class Lizard
  attr_accessor :beats, :name
  def initialize
    @name = 'lizard'
    @beats = ['spock', 'paper']
  end
  
  def to_s
    @name
  end
end

class Spock
  attr_accessor :beats, :name
  def initialize
    @name = 'spock'
    @beats = ['rock', 'scissors']
  end
  
  def to_s
    @name
  end
end

class Player
  attr_accessor :move, :name, :move_hx

  def initialize
    set_name
    @move_hx = []
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose, rock, paper, scissors, spock, lizard"
      choice = gets.chomp
      break if (Move::VALUES).include?(choice)
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
    self.move_hx << self.move.value.name
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Jonny5'].sample
  end

  def choose
    freq_arr = R2D2.freq if self.name = 'R2D2'
    freq_arr = Hal.freq if self.name = 'Hal'
    freq_arr = Chappie.freq if self.name = 'Chappie'
    freq_arr = Jonny5.freq if self.name = 'Jonny5'
    comp_values = []
    (0..4).each do |idx|
      (comp_values << [Move::VALUES[idx]] * freq_arr[idx]).flatten!
    end
    self.move = Move.new(comp_values.sample)
    self.move_hx << self.move.value.name
  end
end

class R2D2
  @@freq = [1, 1, 1, 1, 1]
  def self.freq
    @@freq
  end
end

class Hal
  @@freq = [1, 0, 1, 0, 1]
  def self.freq
    @@freq
  end
end

class Chappie
   @@freq = [0, 0, 0, 0, 1]
  def self.freq
    @@freq
  end
end

class Jonny5
 @@freq = [4, 3, 2, 1, 0]
  def self.freq
    @@freq
  end
end

class Score
  attr_accessor :human, :computer
  
  def initialize
    @computer = 0
    @human = 0
  end
  
  def display(human_name, computer_name)
    puts "The Score:"
    puts "#{human_name}: #{@human}"
    puts "#{computer_name}: #{@computer}"
  end
  
  def human_win
    @human += 1  
  end 
  
  def computer_win
    @computer += 1
  end
  
  def final_winner? 
    human == 10 || computer == 10
  end

end


class RPSGame
  attr_accessor :human, :computer, :score

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = Score.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Spock, Lizard!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"

    if human.move > computer.move
      puts "#{human.name} won!"
      score.human_win
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      score.computer_win
    else
      puts "It's a tie!"
    end
  end
  
  def display_move_hx
    puts "Move History:"
    puts "#{human.name}: #{human.move_hx}"
    puts "#{computer.name}: #{computer.move_hx}"
    puts ""
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n"
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end
  
  def display_final_score
    if score.human == 10
      puts "#{human.name} wins with 10 points!"
    elsif score.computer == 10 
      puts "#{computer.name} wins with 10 points!"
    end
  end

  def play
    display_welcome_message

    loop do
      system 'clear'
      score.display(human.name, computer.name)
      display_move_hx
      human.choose
      computer.choose
      display_winner
      break if score.final_winner?
      break unless play_again?
    end
    display_final_score
    display_goodbye_message
  end
end

RPSGame.new.play
