module DemoHelper
  include ApplicationHelper

  class DemoGame < GameSkeleton
	  def initialize(user_state)
	    @user_state = user_state
	    @game_output = Array.new
	    DemoGame.initilize_actions()
		DemoGame.initialize_states()
		DemoGame.initialize_states_to_actions()
		DemoGame.initialize_states_to_response()
	  end

	  def self.initilize_actions()
	    # This is a mapping from a user action to an updated state.
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

	  def self.initialize_states_to_response()
		  @@states_to_responses['Start'] = "You're in your home. You have a living room, bedroom and a" +
		  " kitchen. Only certain rooms are accessible from where you are. Where would you like to go? "

		  @@states_to_responses['Living Room'] = "You're in the living room. You have a TV in here."

		  @@states_to_responses['Kitchen'] = "You're in the kitchen. There is a fridge and oven. The " +
		  "next room over is your bedroom."

		  @@states_to_responses['Bedroom'] = "You're in the bedroom. Your bed is here."
	  end 

	  def self.initialize_states_to_actions()
	    # This is a mapping from a particular state to the valid actions.
	    @@states_to_actions['Start'] = ['Go to living room', 'Go to kitchen']
	    @@states_to_actions['Living Room'] = ['Turn on TV', 'Play piano']
	    @@states_to_actions['Kitchen'] = ['Go to bedroom', 'Open the fridge', 'Turn on the oven', 'Wash dishes']
	    @@states_to_actions['Bedroom'] = ['Lay in bed', 'Sit on futon', 'Clean room']
	  end 

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
	end
end
