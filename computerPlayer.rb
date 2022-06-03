class ComputerPlayer
    def initialize
        @code = makeCode
        gameLoop
    end

    def makeCode
        puts "Enter a 4 digit code for the computer to crack: "
        return gets.chomp.to_i
    end

    def gameLoop
        @round = 1
        while @round < 12 && win == false
            @computerGuess = generateGuess
        end
    end

    def generateGuess
        guessArray = [1 + rand(6), 1 + rand(6), 1 + rand(6), 1 + rand(6)]
    end
        
end