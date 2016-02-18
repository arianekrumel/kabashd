module DemoHelper
  include ApplicationHelper

  # This class is a simple game with four states:
  	# State 0: Start
  	# State 1: Living Room
  	# State 2: Kitchen
  	# State 3: Bedroom
  # Each state has specific actions which can be performed:
  	# State 0: Go to State 1 or State 2
  	# State 1: Turn on TV or Play piano
  	# State 2: Go to State 3, Open the fridge, Turn on the Oven, or Wash dishes
  	# State 3: Lay in bed, Sit on futon, or Clean room. 
  class DemoGame < GameSkeleton
	  def initialize(user_state)
	    @user_state = user_state
	    @game_output = Array.new
	    @percent = 0
	    DemoGame.initilize_actions()
		DemoGame.initialize_states()
		DemoGame.initialize_states_to_actions()
		DemoGame.initialize_actions_to_response()
		DemoGame.initialize_previous_states()
		DemoGame.initialize_percent_per_action()
	  end

	  def self.initilize_actions()
	    # This is a mapping from a user action to an updated state.
	    @@actions['Go back'] = ''

	    @@actions['Go to living room'] = 'Living Room'
	    @@actions['Turn on TV'] = 'Living Room'
	    @@actions['Play piano'] = 'Living Room'

	    @@actions['Go to kitchen'] = 'Kitchen'
	    @@actions['Open the fridge'] = 'Kitchen'
	    @@actions['Turn on the oven'] = 'Kitchen'
	    @@actions['Wash dishes'] = 'Kitchen'

	    @@actions['Go to bedroom'] = 'Bedroom'
	    @@actions['Lay in bed'] = 'Bedroom'
	    @@actions['Sit on futon'] = 'Bedroom'
	    @@actions['Clean room'] = 'Bedroom'
	  end

	  def self.initialize_states()
	    # This is a mapping from a state to a unique ID.
	    @@states['Start'] = 0
	    @@states['Living Room'] = 1
	    @@states['Kitchen'] = 2    
	    @@states['Bedroom'] = 3
	  end

	  def self.initialize_actions_to_response()
	  	# This is a mapping from an action to a response message.
		@@actions_to_responses['Go to living room'] = "You're in the living room. You have a TV and piano in here."
		@@actions_to_responses['Turn on TV'] = "Should you really be watching TV? You have things to do!"
		@@actions_to_responses['Play piano'] = "Great playing!! This practicing is really paying off."

		@@actions_to_responses['Go to kitchen'] = "You're in the kitchen. There is a fridge, oven, and sink full" +
		" of dishes. The next room over is your bedroom."
		@@actions_to_responses['Open the fridge'] = "You already ate! Do something productive now."
		@@actions_to_responses['Turn on the oven'] = "Why'd you open the oven?! You already cooked..."
		@@actions_to_responses['Wash dishes'] = "These dishes were getting bad. Thanks for cleaning!"

		@@actions_to_responses['Go to bedroom'] = "You're in the bedroom. Your bed and a futon is here." +
		"Your room is a mess."
		@@actions_to_responses['Lay in bed'] = "GET UP! You have stuff to do. No time to be laying around."
		@@actions_to_responses['Sit on futon'] = "GETTTT UP! You have stuff to do. No time for sitting around."
		@@actions_to_responses['Clean room'] = "Whoo! A clean room. Doesn't get much better than this."

		# These states are used for 'Go back' action.
		@@actions_to_responses['Start'] = "You're in your home. You have a living room, bedroom and a" +
		" kitchen. Only certain rooms are accessible from where you are. Where would you like to go? "
		@@actions_to_responses['Living Room'] = "You're in the living room. You have a TV and piano in here."
		@@actions_to_responses['Kitchen'] = "You're in the kitchen. There is a fridge, oven, and sink full of " +
		" dishes. The next room over is your bedroom."
		@@actions_to_responses['Bedroom'] = "You're in the bedroom. Your bed and a futon is here." +
		"Your room is a mess."
	  end 

	  def self.initialize_states_to_actions()
	    # This is a mapping from a particular state to the valid actions.
	    @@states_to_actions['Start'] = ['Go to living room', 'Go to kitchen']
	    @@states_to_actions['Living Room'] = ['Turn on TV', 'Play piano']
	    @@states_to_actions['Kitchen'] = ['Go to bedroom', 'Open the fridge', 'Turn on the oven', 'Wash dishes']
	    @@states_to_actions['Bedroom'] = ['Lay in bed', 'Sit on futon', 'Clean room']
	  end

	  def self.initialize_previous_states()
	  	@@previous_states['Living Room'] = 'Start'
	  	@@previous_states['Kitchen'] = 'Start'
	  	@@previous_states['Bedroom'] = 'Kitchen'
	  end

	  def self.initialize_percent_per_action()
	  	# This is a mapping from a particular action to a percent.
	  	@@percent_per_action['Go Back'] = -10;
		@@percent_per_action['Go to living room'] = 20
		@@percent_per_action['Turn on TV'] = -30
		@@percent_per_action['Play piano'] = 15

		@@percent_per_action['Go to kitchen'] = 30
		@@percent_per_action['Open the fridge'] = -20
		@@percent_per_action['Turn on the oven'] = -20
		@@percent_per_action['Wash dishes'] = 40

		@@percent_per_action['Go to bedroom'] = 20
		@@percent_per_action['Lay in bed'] = -20
		@@percent_per_action['Sit on futon'] = -20
		@@percent_per_action['Clean room'] = 30
	  end
	end
end
