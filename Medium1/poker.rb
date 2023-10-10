class Card
  include Comparable
  attr_reader :rank, :suit

  RANK_STATUS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

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

  def self
    cards
  end
end

class PokerHand
  attr_reader :hand
  def initialize(deck)
    @hand = []
    5.times { @hand << deck }
  end

  def print
    puts hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def card_ranks
    hand.map { |card| card.rank }
  end

  def unique_card_ranks?(number)
    card_ranks.uniq == number
  end

  def royal_flush?
    flush? &&
    hand.all? { |card| Deck::RANKS.slice(8, 5).include?(card.rank) }
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    card_ranks.uniq.each { |rank| return true if card_ranks.count(rank) == 4 }
    false
  end

  def full_house?
    unique_card_ranks?(2)
  end

  def flush?
    hand.all? { |card| hand.first.suit == card.suit }
  end

  def straight?
    unique_card_ranks?(5) &&
    (card_ranks.min..card_ranks.max).to_a == card_ranks
  end

  def three_of_a_kind?
    card_ranks.uniq.each { |rank| return true if card_ranks.count(rank) == 3 }
    false
  end

  def two_pair?
    card_ranks.uniq == 3
  end

  def pair?
    card_ranks.uniq == 4
  end
end