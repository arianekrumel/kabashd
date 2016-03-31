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
		    # This is a mapping from a user action to an updated state.
		    @@actions['University'] = 'Get Situation'

		end 

		def self.initialize_states()
		    @@states['Start'] = 0
		    @@states['University'] = 1
		    @@states['Patient'] = 2
		    @@states['Injury Start'] = 3
		    @@states['Travel'] = 4
		    @@states['Rash'] = 5
		    @@states['Blood Test'] = 6
		    @@states['Diagnosis'] = 7
		    @@states['Treatment'] = 8
		    @@states['Antibotics'] = 9
		    @@states['Done'] = 10
		end

		def self.initialize_states_to_actions()
		end

		def self.initialize_actions_to_response_narrator()
			@@actions_to_responses_narrator['Start'] = "Narrator <div class='card'> Lyme Disease </div>"
		end

		def self.initialize_actions_to_response_nurse()
		end

		def self.initialize_actions_to_response_watson()
		end

		def self.initialize_actions_to_response_patient()
			@@bad_response_to_state['University'] = "Bad Response <div class='card'></div>"
			@@bad_response_to_state['Patient'] = "Bad Response <div class='card'></div>"
			@@bad_response_to_state['Injury Start'] = "Bad Response <div class='card'></div>"
			@@bad_response_to_state['Travel'] = "Bad Response <div class='card'></div>"
			@@bad_response_to_state['Rash'] = "Bad Response <div class='card'></div>"
			@@bad_response_to_state['Blood Test'] = "Bad Response <div class='card'></div>"
			@@bad_response_to_state['Diagnosis'] = "Bad Response <div class='card'></div>"
			@@bad_response_to_state['Treatment'] = "Bad Response <div class='card'></div>"
			@@bad_response_to_state['Antibotics'] = "Bad Response <div class='card'></div>"
		end

		def self.initialize_percent_per_action()
		end

		def self.initialize_bad_response_to_state()
		  	@@bad_response_to_state['Start'] = "Bad Response <div class='card'>Oh c'mon! Let's play " + 
		  	"doctor.</div>"
		end
	end
end
