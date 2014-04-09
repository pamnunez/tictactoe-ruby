require_relative 'tictactoe'


game = TicTacToe.new    #Create instance of TicTacToe game
game.gameBegin()        #Display initial message

while (game.gameend == 0)&&(game.input.downcase != "exit")
    #Run game until gameend flag is triggered
    game.run
end

game.gameEndDisplay     #Display final message



