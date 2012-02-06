module TTTLogic

  class Board

    attr_reader :size, :unplayed_mark, :field, :all_moves
    #attr_accessor :size, :unplayed_mark, :field, :all_moves

    def initialize(size = 3, unplayed_mark = " ")
      #@field = Array.new(size) {Array.new(size, unplayed_mark)}
      @field = Array.new(size*size, unplayed_mark)
      @size = size
      @unplayed_mark = unplayed_mark
      @all_moves = []
    end

    #for text base game
    def layout
      board_line = "\n#{([].fill(0, @size) { "---" }).join('+')}\n"
      arr = []
      self.rows.each do |n|
        arr << n.join(' | ')
      end
      return "\n\n #{arr.join(" #{board_line} ")} \n\n"
    end

    #create array of ranges
    def ranges
      arr = []
      i=0
      (1..@size).each do |n|
        arr << (i...@size*n)
        i = @size*n
      end
      return arr
    end

    #into 2D array
    def rows
      arr = []
      self.ranges.each do |n|
        arr << @field[n]
      end
      return arr
    end

    # def render
    # txt=[]
    # @field.each do
    # |rows| printf rows.map {" %6s "}.join + "\n", *rows
    # end
    # end

    def free_tiles
      available_moves = []
      @field.each_with_index { |n,index| (n == @unplayed_mark) && available_moves << index }
      return available_moves
    end

    #marks the board and could overwrite(!)
    def mark_tile(player_mark, position)
      @field[position] = player_mark
      @all_moves << position
    end

    def unmark_last_tile
      @field[@all_moves.pop] = @unplayed_mark
    end

    def winner_mark

      winning_patern = [
        #horizontal
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],

        #vertical
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],

        #diagonal
        [0, 4, 8],
        [2, 4, 6]

      ].collect { |pos|
        ( field[pos[0]] == field[pos[1]] &&
          field[pos[1]] == field[pos[2]] &&
          field[pos[0]] != @unplayed_mark &&
          field[pos[0]] ) || nil
      }.compact.first

      # unless winning_patern.nil?
      # return winning_patern == @unplayed_mark  ? false : true
      # else
      # return nil
      # end
      return winning_patern
    end


    def draw?
      free_tiles.size == 0 && winner_mark.nil?
    end

    def gameover?
      not self.winner_mark.nil? || self.draw?
    end

  end

end
