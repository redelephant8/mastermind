class HumanPlayer
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
            puts "Enter guess: (4 numbers; 1-6)"
            @guess = gets.chomp.to_i
            separateGuesses(@guess)
            checkGuess
            print "Results: "
            printHints
            @hintRow.clear
            @win = checkWin
            @round += 1
        end

        if @win == true
            puts "You won in #{@round - 1} rounds!"
        else
            puts "You lose! The correct code was #{@code.join}"
        end

        playAgain
    end

    def playAgain
        puts "Would you like to play again?"
        answer = gets.chomp
        if (answer == 'y') 
            Game.new
        else
            puts "Thanks for playing!"
        end
    end

    def separateGuesses(guess)
        for i in 0..3
            @row[3 - i] = guess % 10
            guess = guess / 10
        end
    end

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
                @hintRow[i] = '_'
            end
        end
    end

    def checkGuess
        @counter = 0
        @tempCode = @code.map  { |number| number.to_i } 
        @tempRow = @row.map  { |number| number.to_i } 
        for i in 0..3
            for j in 0..3
                if @tempCode[i] == @row[j] && @tempCode[i] != -1 && @tempRow[j] != -1
                    if i == j
                        @hintRow[i] = "●"
                        @tempCode[i] = -1
                        @tempRow[j] = -1
                        @counter += 1
                    end   
                end
            end
        end

        for i in 0..3
            for j in 0..3
                if @tempCode[i] == @row[j] && @tempCode[i] != -1 && @tempRow[j] != -1
                    if i != j
                        @hintRow[i] = "○"
                        @tempCode[i] = -1
                        @tempRow[j] = -1
                        @counter += 1
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

    def checkWin
        if @row == @code
            return true
        else
            return false
        end
    end
end