class Move
  attr_accessor :choice, :name, :beats

  WINNING_MOVES = {  'rock' => ['scissors', 'lizard'],
                  'paper' => ['rock', 'spock'],
                  'scissors' => ['paper', 'lizard'],
                  'lizard' => ['spock', 'paper'],
                  'spock' => ['rock', 'scissors'] }

  def initialize(choice)
    @name = choice
    @beats = WINNING_MOVES[choice]
  end

  def >(other_move)
    beats.include?(other_move.name)
  end

  def <(other_move)
    other_move.beats.include?(name)
  end

  def to_s
    name
  end
end

class Player
  attr_accessor :move, :name, :move_history, :freq_arr

  def initialize
    set_name
    @move_history = []
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
      choice = gets.chomp.downcase
      puts ""
      break if (Move::WINNING_MOVES.keys).include?(choice)
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
    move_history << move.name
  end
end

class Computer < Player
  # The COMPUTER_PREFERENCES hash assigns different selection personalities for each
  # computer name. The values in the array correspond to their preference for
  # [rock, paper, scissors, lizard, spock] respectively. For example
  # [1, 0, 0, 0, 0] will only select rock. The higher the value, the more
  # likely the item will be selected. Values must be >= 0 and the sum of all
  # values must be >= 1.
  COMPUTER_PREFERENCES = {  'R2D2' => [1, 1, 1, 1, 1], 'Hal' => [1, 0, 1, 0, 1],
                  'Chappie' => [0, 0, 0, 0, 1], 'Jonny5' => [4, 3, 2, 1, 0] }
  def set_name
    self.name = COMPUTER_PREFERENCES.keys.sample
  end

  def choose
    freq_arr = COMPUTER_PREFERENCES[name]
    computer_values = []
    5.times do |idx|
      (computer_values << ([Move::WINNING_MOVES.keys[idx]] * freq_arr[idx])).flatten!
    end
    self.move = Move.new(computer_values.sample)
    move_history << move.name
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
    puts ""
  end

  def record_win(name)
    if Computer::COMPUTER_PREFERENCES.keys.include?(name)
      @computer += 1
    else
      @human += 1
    end
  end

  def display_win(name)
    puts "#{name} won!"
  end

  def final_winner?
    human == 10 || computer == 10
  end
end

module Display
  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Spock, Lizard!"
    puts ""
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end
  
  def display_move_history
    puts "Move History:"
    puts "#{human.name}:"
    p human.move_history
    puts "#{computer.name}:"
    p computer.move_history
    puts ""
  end
  
  def display_status
    system 'clear'
    score.display(human.name, computer.name)
    display_move_history
  end

  def display_goodbye
    if score.human == 10
      puts "#{human.name} wins with 10 points!"
    elsif score.computer == 10
      puts "#{computer.name} wins with 10 points!"
    end
    puts ""
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!"
  end
end

class RPSGame
  attr_accessor :human, :computer, :score
  
  include Display

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = Score.new
  end
  
  def find_winner
    if human.move > computer.move
      record_score(human.name)
    elsif human.move < computer.move
      record_score(computer.name)
    else
      puts "It's a tie!"
    end
    puts ""
  end

  def record_score(name)
    score.record_win(name)
    score.display_win(name)
  end

  def play
    display_welcome_message

    loop do
      display_status
      human.choose
      computer.choose
      display_moves
      find_winner
      sleep(3)
      break if score.final_winner?
    end
    display_goodbye
  end
end

RPSGame.new.play
