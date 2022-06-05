require "colorize"

module Logic
  def printHints
    for i in 0..@hintRow.length
      print " #{@hintRow[i]} "
    end
    puts ""
    puts ""
  end

  def fillHintRows
    @hintRow.shuffle!
    @hintRow = @hintRow.compact
    for i in 0..3
      if @hintRow[i].is_a?(String) == false
        @hintRow[i] = "_"
      end
    end
  end

  def checkGuess(code, guess)
    counter = 0
    tempCode = code.map { |number| number.to_i }
    tempGuess = guess.map { |number| number.to_i }
    for i in 0..3
      for j in 0..3
        if tempCode[i] == guess[j] && tempCode[i] != -1 && tempGuess[j] != -1
          if i == j
            @hintRow[i] = "●"
            tempCode[i] = -1
            tempGuess[j] = -1
            counter += 1
          end
        end
      end
    end

    for i in 0..3
      for j in 0..3
        if tempCode[i] == guess[j] && tempCode[i] != -1 && tempGuess[j] != -1
          if i != j
            @hintRow[i] = "○"
            tempCode[i] = -1
            tempGuess[j] = -1
            counter += 1
          end
        end
      end
    end
    fillHintRows
  end

  def checkMoreThanOne(number)
    counter = 0
    for i in 0..3
      if @row == number
        counter += 1
      end
    end
    return counter
  end

  def checkWin(code, guess)
    if code == guess
      return true
    else
      return false
    end
  end

  def separateGuesses(guess)
    row = Array.new
    for i in 0..3
      row[3 - i] = guess % 10
      guess = guess / 10
    end
    return row
  end

  def playAgain
    puts "Would you like to play again? (y/n)"
    answer = gets.chomp
    if (answer == "y" || answer == "Y")
      Game.new
    else
      puts "Thanks for playing!"
    end
  end

  def backgroundColor(row)
    for i in 0..3
      if row[i] == 1
        print "  #{row[i]}  ".on_red.bold
      elsif row[i] == 2
        print "  #{row[i]}  ".on_cyan.bold
      elsif row[i] == 3
        print "  #{row[i]}  ".on_yellow.bold
      elsif row[i] == 4
        print "  #{row[i]}  ".on_green.bold
      elsif row[i] == 5
        print "  #{row[i]}  ".on_blue.bold
      elsif row[i] == 6
        print "  #{row[i]}  ".on_magenta.bold
      end
    end
    print "  "
  end
end
