class Player
  attr_accessor :hand, :stay

  def initialize
    @hand = {}
    @stay = false
  end

  def hit(card)
    hand.merge!(card)
  end

  def stay?
    stay == true
  end

  def busted?
    total > 21
  end

  def total
    hand.values.sum
  end
end

class Dealer
  attr_reader :hand

  def initialize
    @hand = {}
  end

  def hit(card)
    hand.merge!(card)
  end

  def stay?
    hand.values.sum >= 17
  end

  def busted?
    total > 21
  end

  def total
    hand.values.sum
  end
end

class Participant

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

class Card
  def initialize

  end

end

class Score
  attr_accessor :player, :dealer

  def initialize
    @player = 0
    @dealer = 0
  end

  def player_win
    self.player += 1
  end

  def dealer_win
    self.dealer += 1
  end
end

class Game
  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def deal_cards
    2.times {player.hit(deck.deal_random_card)}
    2.times {dealer.hand.merge!(deck.deal_random_card)}
  end

  def show_initial_cards
    puts "Player Hand: #{player.hand.keys}"
    puts "Dealer Hand: #{dealer.hand.keys}"
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
    show_initial_cards
    if player.busted?
      puts "Player busts! Dealer wins!"
    elsif dealer.busted?
      puts "Dealer busts! Player wins!"
    elsif player.total > dealer.total
      puts "Player wins!"
    elsif dealer.total < player.total
      puts "Dealer wins!"
    else
      puts "It's a tie!"
    end
  end

  def clear
    system 'clear'
  end

  def start
    deal_cards
    show_initial_cards

    loop do
      player_turn
      break if player.busted?
      clear
      dealer_turn
      break if dealer.busted?
      break if dealer.stay? && player.stay?
      show_initial_cards
    end
    show_result
  end
end

Game.new.start
