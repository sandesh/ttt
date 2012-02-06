module TTTLogic

  class Game

    attr_accessor :board, :playerH, :playerAI, :state

    def initialize(board=Board.new, playerH=Human.new(board))
      @board = board
      @playerH = playerH
      @playerAI = AI.new(@board)
    end

    def gameover?
      not @board.winner_mark.nil? || @board.draw?
    end

    # def play
    # end

    def current_player
      @current_player = @board.all_moves.size.even? ? @playerAI : @playerH
      return @current_player
    end

  end

end
