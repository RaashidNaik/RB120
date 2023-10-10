class GuessingGame

  attr_accessor :guesses, :winner, :player_guess
  attr_reader :random_number, :min_number, :max_number

  def initialize(min_number, max_number)
    @min_number = min_number
    @max_number = max_number
    @guesses = Math.log2(max_number - min_number + 1).to_i + 1
    @random_number = rand(min_number..max_number)
    @winner = false
  end

  def ask_player_for_number
    guess_number = nil
    loop do
      puts "Enter a number between #{min_number} and #{max_number}:"
      guess_number = gets.chomp.to_i
      break if (min_number..max_number).include?(guess_number)
      puts "Please guess a number between #{min_number} and #{max_number}:"
    end
    self.guesses -= 1
    @player_guess = guess_number
  end

  def display_guesses_remaining
    puts "You have #{guesses} remaining."
  end

  def evaluate_guess
    if player_guess == random_number
      self.winner = true
    elsif player_guess > random_number
      puts "Your guess is too high"
    else
      puts "Your guess is too low"
    end
    puts ""
  end

  def display_result
    if winner
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end

  def play
    loop do
      display_guesses_remaining
      ask_player_for_number
      evaluate_guess
      break if winner || guesses == 0
    end
    display_result
  end
end

game = GuessingGame.new(501, 1500)
game.play