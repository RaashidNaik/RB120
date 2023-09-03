class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
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
      puts "Please choose, rock, paper or scissors"
      choice = gets.chomp
      break if (Move::VALUES).include?(choice)
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Jonny5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
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
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Good bye!"
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
      score.display(human.name, computer.name)
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
