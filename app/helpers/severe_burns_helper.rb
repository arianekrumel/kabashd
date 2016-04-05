module SevereBurnsHelper
  include ApplicationHelper

  class SevereBurnsGame < GameSkeleton
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

      SevereBurnsGame.initilize_actions()
      SevereBurnsGame.initialize_states()
      SevereBurnsGame.initialize_states_to_actions()
      SevereBurnsGame.initialize_actions_to_response_narrator()
      SevereBurnsGame.initialize_actions_to_response_nurse()
      SevereBurnsGame.initialize_actions_to_response_watson()
      SevereBurnsGame.initialize_actions_to_response_patient()
      SevereBurnsGame.initialize_percent_per_action()
      SevereBurnsGame.initialize_bad_response_to_state()
    end

    def self.initilize_actions()
      @@actions['Get Situation'] = 'Examine'
      @@actions['Examine'] = 'Diagnosis'
      @@actions['Remedy'] = 'Meds'
      @@actions['Meds'] = 'Done'
    end

    def self.initialize_states()
      @@states['Start'] = 0
      @@states['Get Situation'] = 1
      @@states['Examine'] = 2
      @@states['Diagnosis'] = 3
      @@states['Remedy'] = 4
      @@states['Medication'] = 5
      @@states['Done'] = 6
    end

    def self.initialize_states_to_actions()
      # This is a mapping from a particular state to the valid actions.
      @@states_to_actions['']
    end

    def self.initialize_actions_to_response_narrator()
      @@actions_to_responses_narrator['Start'] = "Narrator <div class='card'><p>As you are standing in the " +
      "hallway of the ICU, you see the paramedics rushing by with a patient on a stretcher. CODE RED " +
      "someone yells.</p></div>"
    end

    def self.initialize_actions_to_response_nurse()
      @@actions_to_responses_nurse['Start'] = "Nurse <div class='card'><p>Doctor, we need you in " +
      " here.</p></div>"
    end

    def self.initialize_actions_to_response_watson()
    end

    def self.initialize_actions_to_response_patient()
    end

    def self.initialize_percent_per_action()
    end

    def self.initialize_bad_response_to_state()
      @@bad_response_to_state['Start'] = "Bad Response <div class='card'>Maybe you should ask what's " +
      "going on?</div>"
    end
  end

end
