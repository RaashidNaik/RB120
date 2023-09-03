class Move
  attr_accessor :choice

  GAME_RULES = {  'rock' => ['scissors', 'lizard'],
                  'paper' => ['rock', 'spock'],
                  'scissors' => ['paper', 'lizard'],
                  'lizard' => ['spock', 'paper'],
                  'spock' => ['rock', 'scissors'] }

  def initialize(choice)
    @choice = Items.new(choice)
  end

  def >(other_move)
    choice.beats.include?(other_move.choice.name)
  end

  def <(other_move)
    other_move.choice.beats.include?(choice.name)
  end

  def to_s
    choice.name
  end
end

class Items
  attr_accessor :name, :beats

  def initialize(value)
    @name = value
    @beats = Move::GAME_RULES[value]
  end
end

class Player
  attr_accessor :move, :name, :move_hx, :freq_arr

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
      puts ""
      break if (Move::GAME_RULES.keys).include?(choice)
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
    move_hx << move.choice.name
  end
end

class Computer < Player
  ROBOT_PREF = {  'R2D2' => [1, 1, 1, 1, 1], 'Hal' => [1, 0, 1, 0, 1],
                  'Chappie' => [0, 0, 0, 0, 1], 'Jonny5' => [4, 3, 2, 1, 0] }
  def set_name
    self.name = ROBOT_PREF.keys.sample
  end

  def choose
    freq_arr = ROBOT_PREF[name]
    comp_values = []
    5.times do |idx|
      (comp_values << ([Move::GAME_RULES.keys[idx]] * freq_arr[idx])).flatten!
    end
    self.move = Move.new(comp_values.sample)
    move_hx << move.choice.name
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

  def player_win(name)
    puts "#{name} won!"
    if Computer::ROBOT_PREF.keys.include?(name)
      @computer += 1
    else
      @human += 1
    end
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
    puts ""
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def record_score(name)
    score.player_win(name)
  end

  def display_winner
    if human.move > computer.move
      record_score(human.name)
    elsif human.move < computer.move
      record_score(computer.name)
    else
      puts "It's a tie!"
    end
    puts ""
  end

  def display_move_hx
    puts "Move History:"
    puts "#{human.name}:"
    p human.move_hx
    puts "#{computer.name}:"
    p computer.move_hx
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

  def display_goodbye
    if score.human == 10
      puts "#{human.name} wins with 10 points!"
    elsif score.computer == 10
      puts "#{computer.name} wins with 10 points!"
    end
    puts ""
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!"
  end

  def display_status
    system 'clear'
    score.display(human.name, computer.name)
    display_move_hx
  end

  def play
    display_welcome_message

    loop do
      display_status
      human.choose
      computer.choose
      display_moves
      display_winner
      break if score.final_winner? || !play_again?
    end
    display_goodbye
  end
end

RPSGame.new.play
