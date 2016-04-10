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
		@@goal = nil
		@@keys = Set.new()
		@@repeats = Hash.new()
		@err = nil
		gamestate = GameState.first();
		@@level = gamestate.level
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

	end

	def query

		input = params[:query]
	
		gamestate = GameState.find(current_game.game_state_id)
		
		if(@@level != gamestate.level)
			@@repeats = Hash.new()
		end
		parseGoal(gamestate.goalActions, gamestate.keys)

		if(params[:tag] == "Story")
	
			parseAction(input, gamestate.saveValue)
			@information = "No information to display"
		else
			@information = query_watson(input, "Knowledge")
		end

		@conversations = current_game.conversations
		current_game.save
	end




	##HELPERS##

	def parseGoal(goalActions, keysets)
		@@goal = goalActions.split(", ")

		if(keysets != nil and @@keys.size() == 0)
			keysets = keysets.split("), (")
			for keyset in keysets
				keyset = keyset.tr("()", "").split(", ")
				temp = Hash.new
				for key in keyset
					temp[key] = false
				end
				print(temp)
				print("\n\n")
				@@keys.add(temp)
			end
		end
	end


	def parseAction(input, saveValue)
		
		if saveValue != nil
			current_game[saveValue] = input.titleize()
			action = @@goal[0]
		else
			action = query_watson(input, "Story")
			if(@@repeats.key?(action))
				Conversation.create(query: input, response: @@repeats[action], confidence: nil, game_id: current_game.id)
				return
			end
		end
		
		goalIndex = 0
		for keyset in @@keys
		
			if keyset[action] != nil
				if keyset[action] == true
					break
				else
					keyset[action] = true
					goal = true
					keyset.each do |key, value|
						print value
						if(!value)
							goal = false
						end
					end
					print("\n")
		
					if(goal)
						processResponse(action, input, current_game.id)
						action = @@goal[goalIndex]
						input = ""
						break
					end
				end
			end
			
			goalIndex += 1
		end

		processResponse(action, input, params[:game_id])
		for goal in @@goal
	
			if(action == goal)
				@@goal = nil
				@@keys = Set.new()

				break
			end

		end
	end

	def processResponse(answer, user_input, gameID)
		gamestate = current_game.game_state
		action = gamestate.actions.where(["command = ?", answer]).first

	  	if action
			if action.repeatResponse != nil
				if(action.repeatResponse == "default")
					@@repeats[action.command] = action.response
				else
					@@repeats[action.command] = action.repeatResponse
				end
			end
	  		Conversation.create(query: user_input, response: action.response.gsub("%n", current_game.player_name), confidence: nil,
		game_id: gameID)
			current_game.game_state_id = action.result_state_id

		else

			action = Action.all.where(["command = ?", answer]).first
			if(action and action.earlyResponse != nil)
				Conversation.create(query: user_input, response: action.earlyResponse, confidence: nil, game_id: gameID)
			else
				Conversation.create(query: user_input, response: "Sorry, you can't do that right now.", confidence: nil, game_id: gameID)
			end
	  	end

	end

end

