
gameend = 0
class TicTacToe
    attr_accessor :ai, :player, :gameend, :round, :gameboard, :input, :winner

    def initialize
        @ai = ""
        @player = ""
        @gameend = 0
        @round = 0
        @gameboard = Array.new(3) { [" ", " ", " "] }
        @input = ""
        @winner = ""
    end

    def gameBegin
        puts "Welcome to TicTacRuby!"
        puts "Please select your symbol. X goes first, O goes second. "

        @player = gets.chomp
        while @player !~ /[XO]/
            puts "Invalid input! Please enter X or O: "
            @player = gets.chomp
        end

        if @player == "X" then 
            @ai = "O"
            puts "You will play as X, you will play first."
        else
            @ai = "X"
            puts "You will play as O, you will play second."
        end
        puts ""
    end

    def turnInit(board, roundnum)
        puts "Enter your symbol by indicating the position"
        puts "you prefer with the following numbers:"
        puts ""
        puts "0|1|2"
        puts "-+-+-"
        puts "3|4|5"
        puts "-+-+-"
        puts "6|7|8"
        puts ""
        puts "You may quit the game at any time by entering \"exit\"."
        puts ""
        puts "Round #{roundnum}:"
        puts ""
        puts "#{@gameboard[0][0]}|#{@gameboard[0][1]}|#{@gameboard[0][2]}"
        puts "-+-+-"
        puts "#{@gameboard[1][0]}|#{@gameboard[1][1]}|#{@gameboard[1][2]}"
        puts "-+-+-"
        puts "#{@gameboard[2][0]}|#{@gameboard[2][1]}|#{@gameboard[2][2]}"
        puts ""
        puts "Please enter you choice: "
 
        @input = gets.chomp
        while @input.to_i < 0 || @input.to_i > 8 || @input =~ /\D|^$/
            if @input.downcase == "exit"
                puts "Thanks for playing!"
                exit
            else
                puts "Invalid input! Please enter a number between 0 and 8: "
                @input = gets.chomp
            end
        end

        puts "You have entered #{@input}."
        puts ""
    end

    def run 
        if (gameend == 0) then
            @round+=1
            turnInit(@gameboard, @round)
            userTurn
            checkGameEnd(@player)
            aiTurn
            checkGameEnd(@ai)
        elsif (gameend == 1)
            puts "Thank you for playing!"
            exit
        end
    end

#TODO: WRITE AI FUNCTIONALITY. Once game mechanics are done, AI will be implemented.
    def userTurn
        x = 0
        y = 0
        if @input.to_i <= 2 then
            y = @input.to_i
        elsif @input.to_i > 2 && @input.to_i <= 5
            x = 1
            y = @input.to_i - 3
        elsif @input.to_i > 5
            x = 2
            y = @input.to_i - 6
        end
        @gameboard[x][y] = @player
    end

    def aiTurn

    end

    def checkGameEnd(symbol)
        if @gameboard[0][0] == symbol && @gameboard[1][1] == symbol &&
            @gameboard[2][2] == symbol then
            @gameend = 1
            @winner = symbol 
        elsif @gameboard[0][2] == symbol && @gameboard[1][1] == symbol &&
            @gameboard[2][0] == symbol then
            @gameend = 1
            @winner = symbol
        else
            @gameboard.each do |arr|
                if arr[0] == symbol && arr[1] == symbol && arr[2] == symbol
                    @gameend = 1
                    @winner = symbol
                end
            end
        end
        false
    end

    def gameEndDisplay
    end

end

    game = TicTacToe.new
    game.gameBegin()
    while (game.gameend == 0)&&(game.input.downcase != "exit")
        game.run 
    end


    puts "Thank you for playing!"
#    gameend = 1


