# PRS is a game between 2 players. Both players pick a hand of either "paper", "rock" or "scissors". Then, the two hands are compared and it's either a tie(if hands are the same) or p > r, r > s, and s > p.

class Hand
  include Comparable

  attr_reader :value

  def initialize(v)
    @value = v
  end

  def <=>(another_hand)
    if @value == another_hand.value
      0
    elsif (@value == 'p' && another_hand.value == 'r') || (@value == 'r' && another_hand.value == 's') || (@value == 's' && another_hand.value == 'p')
      1
    else
      -1
    end
  end

  def display_winnig_message
    case @value
    when 'p'
      puts "Paper wraps Rock!"
    when 'r'
      puts "Rock smashes Scissors!"
    when 's'
      puts "Scissors cuts Paper!"
    end
  end
end

class Player
  attr_accessor :hand
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    "#{name} currently has a choice of #{self.hand.value}!"
  end
end

class Human < Player
  def pick_hand
    begin 
      puts "Pick one: (p, r, s):"
      c = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(c)
    puts "You choose '#{c}'."
    self.hand = Hand.new(c)
  end
end  

class Computer < Player
  def pick_hand
    c = Game::CHOICES.keys.sample
    self.hand = Hand.new(c)
    puts "Computer choose '#{c}'."
  end
end

class Game
  CHOICES = {'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissors'}

  attr_reader :player, :computer

  def initialize
    @player = Human.new('You')
    @computer = Computer.new('Computer')
  end

  def compare_hands
    if player.hand == computer.hand
      puts "It's a tie!"
    elsif player.hand > computer.hand
      player.hand.display_winnig_message
      puts "#{player.name} won!"
    else
      computer.hand.display_winnig_message
      puts "#{computer.name} won!"  
    end
  end

  def play
    loop do
      puts "-----------------------------------"
      puts "Welcome to Paper, Rock, Scissors!"
      puts "-----------------------------------"
      player.pick_hand
      computer.pick_hand
      compare_hands
      puts "Play again? (y/n)"
      break if gets.chomp.downcase != 'y'
    end
  end
end

game = Game.new.play
puts "Good bye!"


