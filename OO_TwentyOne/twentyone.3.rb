class Player
  attr_accessor :hand, :name, :score

  def initialize
    @score = 0
  end

  def hit(card)
    hand.cards.merge!(card)
  end

  def win
    self.score += 1
  end
end

class Dealer < Player
  DEALER_STAY_MAX_VALUE = 17

  def initialize
    super
    @name = ['R2D2', 'Jonny5', 'WALL-E', 'Data'].sample
  end

  # def stay?
  #   hand.cards.values.sum >= DEALER_STAY_MAX_VALUE
  # end

end

class Hand
  attr_accessor :cards, :stay

  def initialize
    @cards = {}
    @stay = false
  end

  def busted?
    total > Game::WINNING_HAND_VALUE
  end

  def number_of_aces
    cards.values.count(Deck::CARD_VALUES.last)
  end

  def account_for_aces(sum)
    if sum > Game::WINNING_HAND_VALUE
      number_of_aces.times do
        next if sum <= Game::WINNING_HAND_VALUE
        sum -= 10
      end
    end
    sum
  end

  def dealer_initial_total
   sum = cards.values[1..-1].sum
   account_for_aces(sum)
  end

  def total
    sum = cards.values.sum
    account_for_aces(sum)
  end
end


class Deck
  SUITS = ["Hearts", "Diamonds", "Clubs", "Spades"]
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]
  CARD_NAMES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen'] +
               ['King', 'Ace']

  attr_reader :cards

  def initialize
    @cards = {}
    SUITS.each do |suit|
      CARD_NAMES.each_with_index do |name, idx|
        @cards["#{name} of #{suit}"] = CARD_VALUES[idx]
      end
    end
  end

  def deal_random_card
    card = {}
    card_name = cards.keys.sample
    card[card_name] = cards.delete(card_name)
    card
  end

end

module Display

end

class Game
  NUMBER_OF_GAMES = 5
  WINNING_HAND_VALUE = 21

  attr_reader :deck, :player, :dealer

  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def enter_player_name
    puts "Please enter your name:"
    name = gets.chomp
    player.name = name
  end

  def reset_cards
    @deck = Deck.new
    player.hand = Hand.new
    dealer.hand = Hand.new
  end

  def deal_cards
    2.times {player.hit(deck.deal_random_card)}
    2.times {dealer.hit(deck.deal_random_card)}
  end

  def display_hand(participant_cards)
    participant_cards.each {|card| puts card}
  end

  def show_initial_cards
    puts "** Cards **"
    puts "#{dealer.name} Hand:"
    display_hand(dealer.hand.cards.keys[1..-1].unshift("Hidden Card"))
    puts ""
    puts "#{player.name} Hand:"
    display_hand(player.hand.cards.keys)
    line_break
  end

  def show_final_cards
    puts "** Cards **"
    puts "#{dealer.name} Hand:"
    display_hand(dealer.hand.cards.keys)
    puts ""
    puts "#{player.name} Hand:"
    display_hand(player.hand.cards.keys)
    line_break
  end

  def show_card_total
    puts "** Sum of Cards **"
    puts "#{dealer.name}(visible): #{dealer.hand.dealer_initial_total}"
    puts "#{player.name}: #{player.hand.total}"
    line_break
  end

  def hit_or_stay
    player_decision = nil
    loop do
      puts "Would you like to hit or stay (h/s)?"
      player_decision = gets.chomp.downcase
      break if ["h", "s", "hit", "stay"].include?(player_decision)
      puts "Please enter \"h\" for hit or \"s\" for stay."
    end
    if player_decision.start_with?("h")
      player.hit(deck.deal_random_card)
    else
      player.hand.stay = true
    end
  end

  def player_turn
    if player.hand.stay == false
      hit_or_stay
    end
  end

  def dealer_turn
    if dealer.hand.total <= 17
      dealer.hit(deck.deal_random_card)
    else
      dealer.hand.stay = true
    end
  end
  
  def game_winner
    winner_name
    if 
    
  end
  

  def show_result
    if player.hand.busted?
      puts "#{player.name} busts! Dealer wins!"
      record_score(dealer)
    elsif dealer.hand.busted?
      puts "#{dealer.name} busts! Player wins!"
      record_score(player)
    elsif player.hand.total > dealer.hand.total
      puts "#{player.name} wins!"
      record_score(player)
    elsif dealer.hand.total > player.hand.total
      puts "#{dealer.name} wins!"
      record_score(dealer)
    else
      puts "It's a tie!"
    end
    puts "Press ENTER to continue"
    gets.chomp
  end

  def record_score(winner)
    winner.win
  end

  def clear
    system 'clear'
  end

  def display_score
    puts "** Total Score **"
    puts "#{dealer.name}: #{dealer.score} #{player.name}: #{player.score}"
    line_break
  end

  def show_final_card_total
    puts "** Sum of Cards **"
    puts "#{dealer.name}: #{dealer.hand.total}"
    puts "#{player.name}: #{player.hand.total}"
    line_break
  end

  def line_break
    puts "=" * 20
  end

  def display_during_game
    clear
    display_score
    show_initial_cards
    show_card_total
  end

  def display_after_game
    clear
    display_score
    show_final_cards
    show_final_card_total
  end

  def participant_busted?
    player.hand.busted? || dealer.hand.busted?
  end

  def participants_stay?
    dealer.hand.stay && player.hand.stay
  end

  def final_winner?
    player.score == 5 || dealer.score ==5
  end

  def display_final_winner
    puts "#{player.name} wins the match!" if player.score == 5
    puts "#{dealer.name} wins the match!" if dealer.score == 5
  end

  def main_game
    loop do
      display_during_game
      player_turn
      break if participant_busted?
      dealer_turn
      break if participant_busted?
      break if participants_stay?
    end
  end

  def main_match
     loop do
      reset_cards
      deal_cards
      main_game
      display_after_game
      show_result
      break if final_winner?
    end
  end

  def start
    enter_player_name
    main_match
    display_final_winner
  end
end

game = Game.new
game.start
