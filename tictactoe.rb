
gameend = 0
class TicTacToe
    attr_accessor :player, :gameend, :round, :gameboard, :input

    def initialize
        @player = ""
        @gameend = 0
        @round = 1
        @gameboard = [[0, 0, 0],[0, 0, 0],[0, 0, 0]]
        @input = ""
    end

    def gameBegin
        puts "Welcome to TicTacRuby!"
        puts "Please select your symbol. X goes first, O goes second. "

        begin
            @player = gets.chomp
            @player.match(/[XO]/)
        rescue
            puts "Invalid input! Please enter X or O: "
        end

        if @player == "X" then 
            puts "You will play as X, you will play first."
        else
            puts "You will play as O, you will play second."
        end
        puts ""
    end


    def turnInit(board, roundnum)
        puts "Enter your symbol by indicating the position you prefer with the following numbers: "
        puts "-------"
        puts "|0|1|2|"
        puts "-------"
        puts "|3|4|5|"
        puts "-------"
        puts "|6|7|8|"
        puts "-------"
        puts "You may quit the game at any time by entering \"exit\"."
        puts ""
        puts "Round #{roundnum}:"
        puts "-------"
        puts "|#{@gameboard[0][0]}|#{@gameboard[0][1]}|#{@gameboard[0][2]}|"
        puts "-------"
        puts "|#{@gameboard[1][0]}|#{@gameboard[1][1]}|#{@gameboard[1][2]}|"
        puts "-------"
        puts "|#{@gameboard[2][0]}|#{@gameboard[2][1]}|#{@gameboard[2][2]}|"
        puts "-------"
        puts ""
        puts "Please enter you choice: "
        @input = gets.chomp
        puts "You have entered #{@input}."
    end

    def run
        if (gameend == 0) then
            turnInit(@gameboard, @round)
        end
    end

#TODO: WRITE AI METHOD TO BE CALLED IN WHILE LOOP

end

    game = TicTacToe.new
    game.gameBegin()
    game.run
        
    
    gameend = 1


