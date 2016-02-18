module ApplicationHelper
	class GameSkeleton
		# These class variables are assigned values in subclasses (i.e., for a specific game).
		@@game_state = Hash.new
		@@actions = Hash.new
		@@states_to_actions = Hash.new
		@@states = Hash.new
		@@actions_to_responses = Hash.new
		@@previous_states = Hash.new
		@@percent_per_action = Hash.new

		def get_updated_state(action)
			# Returns the updated state to the user. Also updates the user state.
			state = @@actions[action]
			if not state.nil? and state.empty?
			# Handles the 'Go back' case.
				if @user_state == 'Start'
					return "You are at the start. There is no previous state."
				else
					@user_state = @@previous_states[@user_state]
					return "Action: " + action + " has been performed."
				end
			else
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
					" is an invalid option. Choose again."
				end
			end
		end

		def set_percent_per_action(action)
			@percent += @@percent_per_action[action] != nil ? @@percent_per_action[action] : 0
		end

		def get_percent_per_action()
			return @percent
		end 

		def get_response_by_action(action, state=0)
			if action == 'Go back' || action.empty? || state.nil?
				action = @user_state
			end
			return @@actions_to_responses[action]
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
