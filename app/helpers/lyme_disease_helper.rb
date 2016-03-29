module LymeDiseaseHelper
	include ApplicationHelper

	class LymeDiseaseGame < GameSkeleton
		def initialize(user_state)
		    @user_state = user_state
		    @game_output = Array.new
			@watson_output = Array.new
		    @percent = 0
			@username

		    @@bad_response_to_state = Hash.new
			@@actions_to_responses_narrator = Hash.new
			@@actions_to_responses_nurse = Hash.new
			@@actions_to_responses_watson = Hash.new
			@@actions_to_responses_patient = Hash.new
		
		    LymeDiseaseGame.initilize_actions()
			LymeDiseaseGame.initialize_states()
			LymeDiseaseGame.initialize_states_to_actions()
			LymeDiseaseGame.initialize_actions_to_response_narrator()
			LymeDiseaseGame.initialize_actions_to_response_nurse()
			LymeDiseaseGame.initialize_actions_to_response_watson()
			LymeDiseaseGame.initialize_actions_to_response_patient()
			LymeDiseaseGame.initialize_percent_per_action()
			LymeDiseaseGame.initialize_bad_response_to_state()
		end

		def self.initilize_actions()
			return
		end 

		def self.initialize_states()
		    @@states['Start'] = 0
		end

		def self.initialize_states_to_actions()
			return
		end

		def self.initialize_actions_to_response_narrator()
			@@actions_to_responses_narrator['Start'] = 'Lyme disease game.'
		end

		def self.initialize_actions_to_response_nurse()
		end

		def self.initialize_actions_to_response_watson()
		end

		def self.initialize_actions_to_response_patient()
		end

		def self.initialize_percent_per_action()
			return
		end

		def self.initialize_bad_response_to_state()
		  	@@bad_response_to_state['Start'] = "Bad Response <div class='card'>Oh c'mon! Let's play " + 
		  	"doctor.</div>"
		end
	end
end
