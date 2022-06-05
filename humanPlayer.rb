require_relative "logic.rb"

class HumanPlayer
  include Logic

  def initialize()
    @code = [1 + rand(6), 1 + rand(6), 1 + rand(6), 1 + rand(6)]
    @row = Array.new
    @hintRow = Array.new
    @guess = 0
    @win = false
    rounds
  end

  def rounds()
    puts "Starting Game..."
    @round = 1

    while @round <= 12 && @win == false
      @guess = guessCode(@guess)
      @row = separateGuesses(@guess)
      checkGuess(@code, @row)
      backgroundColor(@row)
      print "Results: "
      printHints
      @hintRow.clear
      @win = checkWin(@code, @row)
      @round += 1
    end

    if @win == true
      puts "You won in #{@round - 1} rounds!"
    else
      puts "You lose! The correct code was #{@code.join}"
    end

    playAgain
  end

  def guessCode(guess)
    flag = false

    while flag == false
      puts "Enter guess: (4 numbers; 1-6)"
      guess = gets.chomp
      if guess.match(/^[1-6]{4}$/)
        flag = true
      else
        puts "Invalid response. Please try again:"
        puts ""
      end
    end
    guess.to_i
  end
end
