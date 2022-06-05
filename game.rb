require_relative "computerPlayer.rb"
require_relative "humanPlayer.rb"

class Game
  def initialize()
    instructions
    @game_type = gets.chomp.to_i
    if @game_type == 1
      @player = HumanPlayer.new
    elsif @game_type == 2
      @player = ComputerPlayer.new
    else
      puts "Invalid game type"
    end
  end

  def instructions
    puts ""
    puts "Welcome to Mastermind!"
    puts "In this game, you will either be making a code for the computer to crack or you will be trying to break the code that the computer creates."
    puts ""
    puts "The code must be 4 pegs long and must be with digits 1-6. The game lasts for 12 rounds"
    puts ""
    puts "After each round, hints are given to the player: "
    puts "● means that a peg is the right color and in the right place"
    puts "○ means that a peg is the right color, but in the wrong place"
    puts "_ means that the peg is the wrong color"
    puts "The clues are randomized so you can't know which clue goes with which peg"
    puts ""
    puts "Let's begin the game:"
    puts ""
    puts "Would you like to make the code or break the code?"
    puts "Type 1 to break the code"
    puts "Type 2 to make the code"
  end
end
