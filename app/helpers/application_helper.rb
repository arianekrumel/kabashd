module ApplicationHelper
	def query_watson(user_input)
		url = 'https://dal09-gateway.watsonplatform.net/instance/579/deepqa/v1/question'
		uri = URI(url)

		request = Net::HTTP::Post.new(uri.path)
		request['Accept'] = 'application/json'
		request['X-SyncTimeout'] = 30
		request['Data-Type'] = 'json'
		request['Content-Type'] = 'application/json'

		request.body = { "question" => {"questionText" => user_input}}.to_json
		request.basic_auth("osu2_student18", "4kT7XGAo")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true

		response = http.request(request)
		puts response.body.as_json

		json_response = JSON.parse(response.body.as_json)["question"]
		if json_response
			all_answers = json_response["evidencelist"]

			i = 0
			# Iterates through the {@code all_answers} to only return an answer that corresponds
			# to a Kabashd document.
			begin
				answer = all_answers[i]["title"]
				i += 1
			end until not answer or answer.include? "Kabashd"

			if answer
				# Removes the title of the document from the answer.
				# This answer represents the "action" that the state machine
				# will understand.
				answer = answer[answer.index(':') + 1..-1].strip()
			end
		end

		#if Watson cannot find an answer return input back to user
		if answer == nil
    return user_input
		end
		
		return answer
	end

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
