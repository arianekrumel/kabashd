module ApplicationHelper
	class GameSkeleton
		# These class variables are initialized in subclasses (i.e., for a specific game). 
		@@game_state = Hash.new
		@@actions = Hash.new
		@@states_to_actions = Hash.new
		@@states = Hash.new
		@@states_to_responses = Hash.new

		def get_response_by_state()
			return @@states_to_responses[@user_state]
		end 

		def set_game_output(input)
			@game_output.push(input)
		end 

		def get_game_output()
			return @game_output
		end 

		def get_state_id(key)
		return @@game_state[key]
		end
	end 
end
