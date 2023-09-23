class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def two_identical_markers_and_unmarked?(squares, player_marker)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if squares.select(&:unmarked?).size != 1
    markers.min == markers.max && markers.min == player_marker
  end

  # returns an empty square (key) if the player or computer almost win or nil
  def almost_winning_marker(player_marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers_and_unmarked?(squares, player_marker)
        computer_choice = line.select do |num|
          @squares[num].marker == Square::INITIAL_MARKER
        end
        return computer_choice.first
      end
    end
    nil
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(num, marker)
    @squares[num].marker = marker
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Score
  @@human = 0
  @@computer = 0

  def self.human
    @@human
  end

  def self.computer
    @@computer
  end

  def self.human_win
    @@human += 1
  end

  def self.computer_win
    @@computer += 1
  end
end

module Display
  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    display_final_winner
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_score
    puts "First player to #{TTTGame::MAXIMUM_SCORE} games wins"
    puts "Games Won: #{human.name}:#{Score.human} #{computer.name}:" \
         "#{Score.computer}"
  end

  def display_board
    display_score
    puts "#{human.name} is #{human.marker}. #{computer.name} is " \
         "#{computer.marker}"
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(arr, delimiter = ', ', conjuction = 'or')
    if arr.size > 1
      arr[0..-2].join(delimiter) + delimiter + conjuction + " #{arr[-1]}"
    else
      arr.first
    end
  end

  def display_result
    clear_screen_and_display_board
    determine_game_winner
    sleep(3)
  end

  def determine_game_winner
    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
      Score.human_win
    when computer.marker
      puts "#{computer.name} won!"
      Score.computer_win
    else
      puts "It's a tie!"
    end
  end

  def display_final_winner
    if Score.human == TTTGame::MAXIMUM_SCORE
      puts "#{human.name} are the final winner!!"
    elsif Score.computer == TTTGame::MAXIMUM_SCORE
      puts "#{computer.name} is the final winner!!"
    end
  end
end

class TTTGame
  include Display

  MAXIMUM_SCORE = 5

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
  end

  def select_names_and_markers
    human_name_and_marker
    computer_name_and_marker
    starting_player
  end

  def human_name_and_marker
    puts "Type in your name:"
    human_name = gets.chomp

    puts "Type in your marker(A-Z):"
    human_marker = nil
    loop do
      human_marker = gets.chomp.upcase
      break if human_marker.size == 1 && ('A'..'Z').include?(human_marker)
      puts "Please choose a marker that is one character only between A and Z."
    end
    @human = Player.new(human_name, human_marker)
  end

  def computer_name_and_marker
    computer_name = ['R2D2', 'Mr.Roboto', 'Jonny5', 'C3P0'].sample

    computer_marker = nil
    loop do
      computer_marker = ('A'..'Z').to_a.sample
      break if computer_marker != human.marker
    end
    @computer = Player.new(computer_name, computer_marker)
  end

  def starting_player
    @current_marker = human.marker
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      break if final_winner?
      reset
    end
  end

  def play
    clear
    display_welcome_message
    select_names_and_markers
    clear
    main_game
    display_score
    display_goodbye_message
  end

  def human_moves
    puts "Choose a square between (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice"
    end

    board[square] = human.marker
  end

  def computer_moves
    if winning_square
      offensive_move
    elsif losing_square
      defensive_move
    else
      random_move
    end
  end

  def winning_square
    board.almost_winning_marker(computer.marker)
  end

  def losing_square
    board.almost_winning_marker(human.marker)
  end

  def offensive_move
    board[winning_square] = computer.marker
  end

  def defensive_move
    board[losing_square] = computer.marker
  end

  def random_move
    random_square = board.unmarked_keys.sample
    board[random_square] = computer.marker
  end

  def final_winner?
    Score.human == MAXIMUM_SCORE || Score.computer == MAXIMUM_SCORE
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    clear
    @current_marker = human.marker
  end

  def current_player_moves
    if @current_marker == human.marker
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end
end

game = TTTGame.new
game.play
