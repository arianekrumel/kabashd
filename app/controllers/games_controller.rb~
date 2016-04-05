require 'net/http'
require 'uri'
require 'json'
include SessionsHelper
include ApplicationHelper
include GamesHelper
class GamesController < ApplicationController
  layout = 'games'
  @user_percent = 50

  def index
    @games = current_user.games
    render :layout => 'application'
  end

  def new
    end_game
    @game = Game.new
    render :layout => 'application'
  end

  def load
    end_game
    @games = current_user.games
    render :layout => 'application'
  end

  def create
    @err = nil
    #@game =  Game.create(params[:game].permit(:name, :time, :user_id))
    gamestate = GameState.first();
    if params[:loaded_game_id] == nil
      @game = Game.new(game_state_id: gamestate.id, name: params[:name], time: 0, user_id: params[:user_id])
      if !@game.save
        @err = @game.errors.messages
        render '/games/new'
        return
      end

    else
      @game = Game.find(params[:loaded_game_id])
    end

    start_game (@game)

    @conversations = current_game.conversations
    render '/games/query'

    #@err = user.errors.messages
    #@game = Game.new
  end

  def query
    	user_input = params[:query]
	answer = query_watson(user_input, params[:tag]).strip

	gamestate = GameState.find(current_game.game_state_id)


	if(params[:tag] == "Story")

		case current_game.game_state.level
		
			when "Sprained_Ankle"
				print answer
				if(current_game.player_name == nil)
					current_game.player_name = user_input.titleize
					answer = "Name"

				elsif(answer == "Ice Ankle")
					if(current_game.ankle_iced)
						answer = "Already Done"
					elsif current_game.game_state.diagnosisMade == true 
						current_game.ankle_iced = true
						if current_game.ankle_elevated and current_game.ankle_rested
							processResponse(answer, user_input, params[:game_id])
							user_input = ""
							answer = "Finished Treating"
						end
					end

				elsif(answer == "Elevate Ankle")
					if(current_game.ankle_elevated)
						answer = "Already Done"
					elsif current_game.game_state.diagnosisMade == true 
						current_game.ankle_elevated = true
						if current_game.ankle_iced and current_game.ankle_rested
							processResponse(answer, user_input, params[:game_id])
							user_input = ""
							answer = "Finished Treating"
						end
					end

				elsif(answer == "Rest")
					if(current_game.ankle_rested)

						answer = "Already Done"
					elsif current_game.game_state.diagnosisMade == true 
						current_game.ankle_rested = true

						if current_game.ankle_iced and current_game.ankle_elevated
							processResponse(answer, user_input, params[:game_id])
							user_input = ""
							answer = "Finished Treating"
						end
					end
				end

				processResponse(answer, user_input, params[:game_id])

			when "Lyme_Disease"

			when "Burn"

			else

		end

		@information = "No information to display"
	else
		@information = answer
	end

	@conversations = current_game.conversations
	current_game.save
  end

	def processResponse(answer, user_input, gameID)
		gamestate = current_game.game_state
		action = gamestate.actions.where(["command = ?", answer]).first

	  	if action

	  		Conversation.create(query: user_input, response: action.response.gsub("%n", current_game.player_name), confidence: nil,
		game_id: gameID)
			current_game.game_state_id = action.result_state_id

		else
			Conversation.create(query: user_input, response:
	"Sorry, you can't do that right now", confidence: nil, game_id: gameID)
	  	end

	end


end
