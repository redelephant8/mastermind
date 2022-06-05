require "pry"
require_relative "logic.rb"

class ComputerPlayer
  include Logic

  def initialize
    @code = makeCode
    @row = Array.new
    @win = false
    @hintRow = Array.new
    @correctPlacement = Array.new
    @incorrectPlacement = Array.new
    @incorrectIndex = Array.new
    @guessArray = Array.new
    @falsePlacement = Array.new
    @guesses = Array.new
    gameLoop
  end

  def makeCode
    flag = false
    while flag == false
      puts "Enter a 4 digit code for the computer to crack: (1-6)"
      code = gets.chomp
      if code.match(/^[1-6]{4}$/)
        flag = true
      else
        puts "Invalid response. Please try again:"
      end
    end
    code.to_i
  end

  def gameLoop
    @round = 1
    while @round < 12 && @win == false
      @computerGuess = generateGuess(@guessArray)
      removingDuplicates(@computerGuess)
      @computerGuess = generateGuess(@guessArray)
      @guesses << @computerGuess
      @row = separateGuesses(@code)
      checkGuess(@row, @computerGuess)
      checkPlacement
      backgroundColor(@computerGuess)
      puts "The computer guessed #{@computerGuess.join}"
      print "Results: "
      printHints
      @hintRow.clear
      @win = checkWin(@computerGuess, @row)
      @round += 1
      sleep(1)
    end

    if @win == true
      puts "The computer won in #{@round - 1} rounds!"
    else
      puts "You win! The computer couldn't guess your code!"
    end

    playAgain
  end

  def generateGuess(guessArray)
    flag = false
    while flag == false
      guessArray = [1 + rand(6), 1 + rand(6), 1 + rand(6), 1 + rand(6)]
      for i in 0..3
        if @correctPlacement[i].is_a?(Integer)
          guessArray[i] = @correctPlacement[i]
        end
        if @incorrectPlacement[i].is_a?(Integer)
          index = generateChange(guessArray)
          guessArray[index] = @incorrectPlacement[i]
        end
      end

      for i in 0..3
        if guessArray.include?(@falsePlacement[i])
          index = guessArray.find_index(@falsePlacement[i])
          guessArray[index] = changeFalse(guessArray)
        end
      end

      if @guesses.include?(guessArray) == false
        flag = true
      end
    end
    guessArray
  end

  def generateChange(guessArray)
    flag = false
    while flag == false
      index = rand(4)
      if guessArray[index] != @correctPlacement[index]
        flag = true
      end
    end
    return index
  end

  def changeFalse(guessArray)
    flag = false
    while flag == false
      temp = 1 + rand(6)
      if @falsePlacement.include?(temp) != true
        flag = true
      end
    end

    return temp
  end

  def removingDuplicates(guessArray)
    tempCorrectPlacement = @correctPlacement.map { |number| number }
    tempIncorrectPlacement = @incorrectPlacement.map { |number| number }
    for i in 0..3
      for j in 0..3
        if tempCorrectPlacement[i] == @incorrectPlacement[j] && tempCorrectPlacement[i] != -1 && tempIncorrectPlacement[j] != -1
          @incorrectPlacement.delete_at(j)
          tempCorrectPlacement[i] = -1
          tempIncorrectPlacement[j] = -1
        end
      end
    end
  end

  def checkPlacement
    counter = 0
    tempCode = @row.map { |number| number.to_i }
    tempGuess = @computerGuess.map { |number| number.to_i }
    for i in 0..3
      for j in 0..3
        if tempCode[i] == @computerGuess[j] && tempCode[i] != -1 && tempGuess[j] != -1
          if i == j
            @correctPlacement[i] = tempCode[i]
            tempCode[i] = -1
            tempGuess[j] = -1
            counter += 1
          end
        end
      end
    end

    for i in 0..3
      for j in 0..3
        if tempCode[i] == @computerGuess[j] && tempCode[i] != -1 && tempGuess[j] != -1
          if i != j
            if @incorrectPlacement.include?(tempCode[i]) == false
              @incorrectPlacement << tempCode[i]
              @incorrectIndex << i
              tempCode[i] = -1
              tempGuess[j] = -1
              counter += 1
            end
          end
        end
      end

      if @row.include?(@computerGuess[i]) == false && @falsePlacement.include?(@computerGuess[i]) == false
        @falsePlacement << (@computerGuess[i])
      end
    end
  end
end
