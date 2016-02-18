module MedicalHelper
  include ApplicationHelper


  # This class is a simple game with one state:
  # There is room to modify later
  	# State 0: Emergency Room
  # Each state has specific actions which can be performed:
  	# State 0: Talk to patient, X-ray patient, Re-align Bone, Get patient a cast

  class Gamestate < GameSkeleton

    @@actions_to_responses = Hash.new

    def initialize(user_state)
      @user_state = user_state
      @game_output = Array.new
      Gamestate.initilize_actions()
    Gamestate.initialize_states()
    Gamestate.initialize_states_to_actions()
    Gamestate.initialize_states_to_response()
    Gamestate.initialize_actions_to_response()
    end

    def self.initilize_actions()
      # This is a mapping from a user action to an updated state.
      @@actions['Talk to patient'] = 'Emergency Room'
      @@actions['X-ray patient'] = 'Emergency Room'
      @@actions['Get patient a cast'] = 'Emergency Room'
      @@actions['Re-align Bone'] = 'Emergency Room'
    end

    def self.initialize_states()
      # This is a mapping from a state to a unique ID.
      @@states['Emergency Room'] = 0

    end

    def self.initialize_states_to_response()
      # This is a mapping from a state to a response message.
    @@states_to_responses['Emergency Room'] = "A man walks in. His arm hurts, he thinks it could be broken. You need to fix him and send him on his way "

    end

    def self.initialize_states_to_actions()
      # This is a mapping from a particular state to the valid actions.
      @@states_to_actions['Emergency Room'] = ['Talk to patient', 'X-ray patient','Re-align Bone', 'Get patient a cast']

    end

    def self.initialize_actions_to_response()
        @@actions_to_responses['Talk to patient'] = "Well doc, I was milking my cows like I do every morning, only I slipped and fell.
        Bettsy happened to hoof my arm a little, it's swelled up like a grapefruit and hurts something fierce.
         She does weigh quite a bit you know."

        @@actions_to_responses['X-ray patient'] = "You take the patient to get an x-ray.
        Luckily you remembered where that room was.
        The image shows a small break - you think it's a hairline fracture"

        @@actions_to_responses['Re-align Bone'] = "After icing the patient, you re-align the bone."

        @@actions_to_responses['Get patient a cast'] = "You gladly pawn off the job of applying the cast to a helpful nurse
              You successfully healed your first patient!"

    end

    def get_response_by_action(user_input)
      return @@actions_to_responses[user_input]
    end

  end
end
