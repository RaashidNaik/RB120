class Card
  include Comparable
  attr_reader :rank, :suit

  RANK_STATUS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    RANK_STATUS.index(rank) <=> RANK_STATUS.index(other.rank)
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_reader :cards

  def initialize
    reset
  end

  def reset
    @cards = []
    RANKS.each { |rank| SUITS.each { |suit| @cards << Card.new(rank, suit) } }
    @cards.shuffle!
  end

  def draw
    reset if @cards.empty?
    cards.pop
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13


drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.

