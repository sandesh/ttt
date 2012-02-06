module GameHelper

  def generate_play_again
    if @current_game.board.gameover? || @current_game.board.draw?
      display_game_results
      return ("<form method='POST' action='/game/start'>" +
            "<input type=\"submit\" value=\"Play Again?\" />" +
          "</form>")
      end
    
    return ( "<form method='GET' action='/game/start'>" +
              "<input type=\"submit\" value=\"Restart\" />" +
            "</form>")
  end
    
  def generate_state
    if @current_game.state
      return "#{@current_game.state}"
    end
    return ""
  end
  
  def generate_board
    board_html = ""
    @current_game.board.ranges.each do |n|
      html = ""
      n.each do |i|
        html += generate_tiles(i)
      end
      board_html += "#{html}<br />"
    end
    return board_html
  end
  
  def generate_tiles(i)
    
    if @current_game.board.free_tiles.include?(i)
      a_start = "<a href=\"/game/start?turn=#{i}\">"
      a_end = "</a>"
      image = "empty_tile.png"
      on_mouse_over = "onmouseover=\"ttt.mouseOverTile(this)\""
      on_mouse_out = "onmouseout=\"ttt.mouseOutTile(this)\""
    else
      a_start = a_end = on_mouse_over = on_mouse_out = ""
      image = "#{@current_game.board.field[i].downcase}.png"
    end
    "#{a_start}<img id=\"tile\" border=\"1\" src=\"/assets/#{image}\" " +
      "alt=\"tiles\" width=\"125\" height=\"125\" " +
      "#{on_mouse_over} #{on_mouse_out}/>#{a_end}"
  end

  def display_message(text=nil)
    @current_game.state = text
  end

  def display_game_results(winner=@current_game.board.winner_mark)   
    if @current_game.board.draw?
        display_message("It is a DRAW!")
     else
        display_message("The winner is #{winner}")
    end
  end

end
