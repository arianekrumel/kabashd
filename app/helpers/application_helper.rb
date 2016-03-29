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
			test = ''
			i = 0
			# Iterates through the {@code all_answers} to only return an answer that corresponds
			# to a Kabashd document.
			begin
				if all_answers[i]
					answer = all_answers[i]["title"]
					meta_answer = all_answers[i]["metadataMap"] ? 
					all_answers[i]["metadataMap"]["originalfile"] : ""
				else 
					return [nil, nil]
				end
				i += 1
			end until (answer and answer.include? "Kabashd" ) or (meta_answer and meta_answer.include? "Kabashd")

			if answer and answer.include? ":"
				# Removes the title of the document from the answer.
				# This answer represents the "action" that the state machine
				# will understand.
				answer = answer[answer.index(':') + 1..-1].strip()
			end
		end

		#if Watson cannot find an answer return input back to user
		if answer == nil
    		return [user_input, nil]
		end
		
		return [answer, all_answers[i - 1]["text"]]
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

		@@actions_to_responses_narrator = Hash.new
		@@actions_to_responses_nurse = Hash.new
		@@actions_to_responses_watson = Hash.new
		@@actions_to_responses_patient = Hash.new

		def get_updated_state(action)
			# Returns the updated state to the user. Also updates the user state.
			state = @@actions[action]

			if not state.nil?
				# Check if this is a valid state based on where the user is currently at.
				if @@states_to_actions[@user_state].include? action
					@user_state = state
					return @user_state
				end
			end

			return nil
		end

		def updated_state(action)
			# Only call this method when you know the action is in the {@code actions} hashmap.
			@user_state = @@actions[action]
			return @user_state
		end

		def set_percent_per_action(action)
			@percent += @@percent_per_action[action] != nil ? @@percent_per_action[action] : 0
		end

		def get_percent_per_action()
			return @percent
		end

		def get_user_state()
			return @user_state
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

		def get_narrator_response(action)
			return @@actions_to_responses_narrator[action]
		end

		def get_watson_response(action)
			return @@actions_to_responses_watson[action]
		end

		def get_patient_response(action)
			return @@actions_to_responses_patient[action]
		end

		def get_nurse_response(action)
			return @@actions_to_responses_nurse[action]
		end

		def get_watson_output()
			return @watson_output
		end

		def get_all_responses(action='Start')
			narrator_response = get_narrator_response(action)
			if narrator_response and not narrator_response.empty?
				@game_output << get_narrator_response(action)
			end

			nurse_response = get_nurse_response(action)
			if nurse_response and not nurse_response.empty?
				@game_output << get_nurse_response(action)
			end

			patient_response = get_patient_response(action)
			if patient_response and not patient_response.empty?
				@game_output << get_patient_response(action)
			end

			watson_response = get_watson_response(action)
			if watson_response and not watson_response.empty?
				@watson_output << get_watson_response(action)
			end
		end

		def get_watson_output()
			return @watson_output
		end
	end
end
