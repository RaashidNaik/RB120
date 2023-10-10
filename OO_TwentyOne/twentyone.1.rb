class Player
  attr_accessor :hand, :stay, :name, :score

  def initialize
    @hand = {}
    @score = 0
    @stay = false
  end

  def hit(card)
    hand.merge!(card)
  end

  def stay?
    stay == true
  end

  def busted?
    total > Game::WINNING_HAND_VALUE
  end

  def total
    hand.values.sum
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

  def stay?
    hand.values.sum >= DEALER_STAY_MAX_VALUE
  end

  def initial_total
    sum = 0
    hand.values.each_with_index do |value, idx|
      next if idx == 0
      sum += value
    end
    sum
  end
end

class Hand
  def initialize
    cards = {}
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

  def reset_game
    @deck = Deck.new
    player.hand = {}
    dealer.hand = {}
    player.stay = false
    dealer.stay = false
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
    display_hand(dealer.hand.keys[1..-1].unshift("Hidden Card"))
    puts ""
    puts "#{player.name} Hand:"
    display_hand(player.hand.keys)
    line_break
  end

  def show_final_cards
    puts "** Cards **"
    puts "#{dealer.name} Hand:"
    display_hand(dealer.hand.keys)
    puts ""
    puts "#{player.name} Hand:"
    display_hand(player.hand.keys)
    line_break
  end

  def show_card_total
    puts "** Sum of Cards **"
    puts "#{dealer.name}(visible): #{dealer.initial_total}"
    puts "#{player.name}: #{player.total}"
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
      player.stay = true
    end
  end

  def player_turn
    if player.stay == false
      hit_or_stay
    end
  end

  def dealer_turn
    if dealer.total <= 17
      dealer.hit(deck.deal_random_card)
    end
  end

  def show_result
    clear
    show_final_cards
    show_final_card_total
    if player.busted?
      puts "Player busts! Dealer wins!"
      record_score(dealer)
    elsif dealer.busted?
      puts "Dealer busts! Player wins!"
      record_score(player)
    elsif player.total > dealer.total
      puts "Player wins!"
      record_score(player)
    elsif dealer.total < player.total
      puts "Dealer wins!"
      record_score(dealer)
    else
      puts "It's a tie!"
    end
    sleep(3)
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
    puts "#{dealer.name}: #{dealer.total}"
    puts "#{player.name}: #{player.total}"
    line_break
  end

  def line_break
    puts "=" * 20
  end

  def start
    enter_player_name
    loop do
      clear
      reset_game
      deal_cards
      display_score
      show_initial_cards
      show_card_total
      loop do
        player_turn
        break if player.busted?
        clear
        display_score
        dealer_turn
        break if dealer.busted?
        break if dealer.stay? && player.stay?
        show_initial_cards
      end
      show_result
    end
  end
end

game = Game.new
game.start
