

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
        while @player !~ /[XO]/ do
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
    end

    def turnInit(sym)
        puts "Round #{@round}: #{sym}"
        puts ""
        puts "#{@gameboard[0][0]}|#{@gameboard[0][1]}|#{@gameboard[0][2]}"
        puts "-+-+-"
        puts "#{@gameboard[1][0]}|#{@gameboard[1][1]}|#{@gameboard[1][2]}"
        puts "-+-+-"
        puts "#{@gameboard[2][0]}|#{@gameboard[2][1]}|#{@gameboard[2][2]}"
        puts ""
    end

    def turnInput
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
         if @player == "X" then
            turnInput
            userTurn
            turnInit(@player)
            checkGameEnd(@player)
            aiTurn
            turnInit(@ai)
            checkGameEnd(@ai)
          elsif @player == "O" then
            aiTurn
            turnInit(@ai)
            checkGameEnd(@ai)
            turnInput
            userTurn
=begin 
            while userTurn == false do
                puts "That space is already filled!"
                turnInput
            end
=end
            turnInit(@player)
            checkGameEnd(@player)
          end
        elsif (gameend == 1)
            puts "Thank you for playing!"
            exit
        end
    end

#TODO: WRITE AI FUNCTIONALITY. Once game mechanics are done, AI will be implemented.
    def userTurn
        @round+=1
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
        
        if @gameboard[x][y] != " " then 
            puts "gameboard = #{@gameboard}"
            return false
        else 
            @gameboard[x][y] = @player
            puts "gameboard = #{@gameboard}"
            return true
        end
    end

#the fill param allows me to choose whether I want to fill in a winning move or just check for one
    def winningMove(rows, cols, diag, winner, loser, fill)
        rows.each do |row|
            if !row.include?(loser) && row.count(winner) == 2 then
                row.fill(winner) if fill
                checkGameEnd(winner)
                return row
            end
        end
        cols.each do |col|
            if !col.include?(loser) && col.count(winner) == 2 then
                (for i in 0..2 do col[i].replace(winner) end) if fill
                checkGameEnd(winner)
                return col
            end
        end
        diag.each do |dia|
            if !dia.include?(loser) && dia.count(winner) == 2 then
                (for i in 0..2 do dia[i].replace(winner) end) if fill
                return dia
            end
        end
        false
    end

    def aiTurn
        @round+=1
        row1 = @gameboard[0]
        row2 = @gameboard[1]
        row3 = @gameboard[2]
        col1 = []
        col2 = []
        col3 = []
        col1 << @gameboard[0][0] << @gameboard[1][0] << @gameboard[2][0]
        col2 << @gameboard[0][1] << @gameboard[1][1] << @gameboard[2][1]
        col3 << @gameboard[0][2] << @gameboard[1][2] << @gameboard[2][2]
        diag1 = []
        diag2 = []
        diag1 << @gameboard[0][0] << @gameboard[1][1] << @gameboard[2][2]
        diag2 << @gameboard[0][2] << @gameboard[1][1] << @gameboard[2][0]
        rows = [row1, row2, row3]
        cols = [col1, col2, col3]
        diag = [diag1, diag2]
        winningMove(rows, cols, diag, @ai, @player, true)
        puts "gameend = #{@gameend}"
        if winningMove(rows, cols, diag, @player, @ai, false) != false && @gameend == 0 then
            puts "true"
            block = winningMove(rows, cols, diag, @player, @ai, false)
            block[block.find_index(" ")].replace(@ai)
        end
    end

    def checkGameEnd(sym)
        if @gameboard[0][0] == sym && @gameboard[1][1] == sym &&
            @gameboard[2][2] == sym then
            @gameend = 1
            @winner = sym
        elsif @gameboard[0][2] == sym && @gameboard[1][1] == sym &&
            @gameboard[2][0] == sym then
            @gameend = 1
            @winner = sym
        else
            for i in 0..2
                if @gameboard[i][0] == sym && @gameboard[i][1] == sym && 
                    @gameboard[i][2] == sym then
                    @gameend = 1
                    @winner = sym
                end
                if @gameboard[0][i] == sym && @gameboard[1][i] == sym && 
                    @gameboard[2][i] == sym then
                    @gameend = 1
                    @winner = sym
                end
            end
        end
    end

    def gameEndDisplay
        if gameend == 1 && winner == "" then
            puts "Thanks for playing!"
        else
            puts "Final board:"
            puts ""
            puts "#{@gameboard[0][0]}|#{@gameboard[0][1]}|#{@gameboard[0][2]}"
            puts "-+-+-"
            puts "#{@gameboard[1][0]}|#{@gameboard[1][1]}|#{@gameboard[1][2]}"
            puts "-+-+-"
            puts "#{@gameboard[2][0]}|#{@gameboard[2][1]}|#{@gameboard[2][2]}"
            puts ""
            if @winner == @player
                puts "You're the winner! Congratulations!"
            elsif @winner == @ai
                puts "Sorry, I win! Better luck next time!"
            end
            puts "Thanks for playing!"
        end
    end

end

    game = TicTacToe.new
    game.gameBegin()
    while (game.gameend == 0)&&(game.input.downcase != "exit")
        #game.gameboard[0][0] = "O"
        #game.gameboard[1][0] = "O"
        game.gameboard[0][1] = "X"
        game.gameboard[1][1] = "X"
        game.run
    end
    game.gameEndDisplay


