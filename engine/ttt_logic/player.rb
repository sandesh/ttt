module TTTLogic

  class Player

    attr_accessor :mark, :board

    def initialize(mark, board)
      @mark = mark
      @board = board
    end

    def next_move_possible?(move_position)
      return @board.free_tiles.index(move_position.to_i).nil? ? false : true
    end

  end


  class Human < Player

    def initialize(mark = "X", board)
      super(mark,board)
    end

    def move(move_position)
      next_move_possible?(move_position) && @board.mark_tile(@mark,move_position)
    end

  end


  class AI < Player

    def initialize(mark = "O", board)
      super(mark,board)
      @human_mark = "X"
    end

    def move
      move_position,score = self.max_move
      @board.mark_tile(@mark,move_position)
    end

    def max_move

      optimal_position = 0
      optimal_score = 0

      for pos in @board.free_tiles do
          @board.mark_tile(@mark,pos)

          if @board.gameover?
            score = self.score_rank
          else
            move_pos, score = self.min_move
          end

          @board.unmark_last_tile

          if optimal_score == 0 or score > optimal_score

            optimal_position = pos
            optimal_score = score

          end

        end

        return optimal_position, optimal_score
      end

      def min_move

        optimal_position = 0
        optimal_score = 0

        for pos in @board.free_tiles do
            @board.mark_tile(@human_mark,pos)

            if @board.gameover?
              score = self.score_rank
            else
              move_pos, score = self.max_move
            end

            @board.unmark_last_tile

            if optimal_score == 0 or score < optimal_score
              optimal_position = pos
              optimal_score = score
            end
          end

          return optimal_position, optimal_score
        end

        def score_rank
          if @board.gameover?
            if  @board.winner_mark == self.mark
              return 1
            elsif @board.winner_mark == @human_mark
              return -1
            end
          end
          return 0
        end

      end

    end
