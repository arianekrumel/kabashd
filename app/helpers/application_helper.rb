module ApplicationHelper
	class GameSkeleton
		# These class variables are assigned values in subclasses (i.e., for a specific game). 
		@@game_state = Hash.new
		@@actions = Hash.new
		@@states_to_actions = Hash.new
		@@states = Hash.new
		@@states_to_responses = Hash.new

		def get_updated_state(action)
			# Returns the updated state to the user. Also updates the user state.
			state = @@actions[action]
			if state != nil
				# Check if this is a valid state based on where the user is currently at.
				if @@states_to_actions[@user_state].include? action
					@user_state = state
					return "Action: " + action + " has been performed."
				else
					# User can not perform this action based on their current state.
					return "You can not " + action.downcase + " from the " + @user_state.downcase +
					". Please choose again."
				end
			else
				# This is state is not in this game.
				return "You're in the " + @user_state.downcase + ". Unfortunately, " + action.downcase +
				" is not a valid option. Chose again."
			end 
		end 

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
