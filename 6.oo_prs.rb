class Hand
  include Comparable

  attr_reader :value

  def initialize(v)
    @value = v
  end

  def <=>(another_hand)
    if value == another_hand.value
      0
    elsif (value == 'p' && another_hand.value == 'r') || (value == 'r' && another_hand.value == 's') || (value == 's' && another_hand.value == 'p')
      1
    else
      -1
    end
  end

  def display_winning_message
    case value
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
end

class Human < Player
  def pick_hands
    begin
      puts "Pick one: (p/r/s)"
      c = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(c)
      puts "#{name} choose '#{c}'."
      self.hand = Hand.new(c)
  end
end

class Computer < Player
  def pick_hands
    c = Game::CHOICES.keys.sample
    puts "#{name} choose '#{c}'."
    self.hand = Hand.new(c)
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
      player.hand.display_winning_message
      puts "#{player.name} win!"
    else
      computer.hand.display_winning_message
      puts "#{computer.name} win!"
    end
  end

  def replay
    play_again_choice = 'n'

    while play_again_choice != 'y'
      puts "\nWould you like to play again? (y/n)"
      play_again_choice = gets.chomp.downcase

      unless %w(y n).include?(play_again_choice)
      #unless = if not
        puts "Error!!! Invalid entry. Please enter either 'y' or 'n'."
      next  
      end

      if play_again_choice == 'y'
        Game.new.play
      elsif play_again_choice == 'n'
        puts "Thanks for playing!"
        exit
      end
    end
  end

  def play
    loop do 
      system "clear"
      puts "-------------------------------------"
      puts "Welcome to Paper, Rock, and Scissors!"
      puts "-------------------------------------"
      player.pick_hands
      computer.pick_hands
      compare_hands
      replay
    end
  end
end

game = Game.new.play
