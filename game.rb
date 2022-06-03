require 'pry-byebug'
require_relative 'computerPlayer.rb'
require_relative 'humanPlayer.rb'

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
        puts "Welcome to Mastermind!"
        puts "Would you like to make the code or break the code?"
        puts "Type 1 to break the code"
        puts "Type 2 to make the code"
    end
end