class GuessingGame
  MAX_GUESSES = 7
  MIN_NUMBER = 1
  MAX_NUMBER = 100

  attr_accessor :guesses, :winner, :player_guess
  attr_reader :random_number

  def initialize
    @guesses = MAX_GUESSES
    @random_number = rand(MIN_NUMBER..MAX_NUMBER)
    @winner = false
  end

  def ask_player_for_number
    guess_number = nil
    loop do
      puts "Enter a number between #{MIN_NUMBER} and #{MAX_NUMBER}:"
      guess_number = gets.chomp.to_i
      break if (MIN_NUMBER..MAX_NUMBER).include?(guess_number)
      puts "Please guess a number between #{MIN_NUMBER} and #{MAX_NUMBER}:"
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


game = GuessingGame.new
game.play

=begin

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guess remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!

=end