$: << File.expand_path(File.dirname(__FILE__))
require 'ttt_logic/player'
require 'ttt_logic/board'
require 'ttt_logic/game'

# #Tesing
# g = TTTLogic::Game.new
# # 
# puts g.current_player
# # 
# g.playerH.move(7)
# # 
# puts g.board.all_moves.inspect
# puts g.board.field.inspect
# puts g.board.winner_mark.inspect
# 
# 
# g.playerAI.move
# 
# 
# puts g.board.all_moves.inspect
# puts g.board.free_tiles.inspect
# 
# puts g.board.layout
# puts g.playerAI.score_rank
