class GameController < ApplicationController
  
  def index
    
  end
  
  def start

    if params[:turn]
      
       @current_game = Marshal.load(cookies[:game_state])
       @current_game.playerH.move(params[:turn].to_i)      
       @current_game.playerAI.move
       
    else
      
       cookies[:game_state] = nil
       @current_game = TTTLogic::Game.new
       @current_game.state = "Your turn is next, HUMAN!"
       #AI plays first
       @current_game.playerAI.move
       
    end
    
    #store the instance in cookies, yes it's ungly and a big no-no
    cookies[:game_state] =  {
      :value => Marshal.dump(@current_game),
      :expires => 15.minutes.from_now
    }
    
  end

end
