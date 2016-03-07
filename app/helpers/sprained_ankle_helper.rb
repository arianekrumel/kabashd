module SprainedAnkleHelper
	include ApplicationHelper

	class SprainedAnkleGame < GameSkeleton
		def initialize(user_state)
		    @user_state = user_state
		    @game_output = Array.new
		    @percent = 0
		    @remedy_values = [0, 0, 0]
			@watson_output = Array.new

		    @@bad_response_to_state = Hash.new 
			@@actions_to_responses_narrator = Hash.new
			@@actions_to_responses_nurse = Hash.new
			@@actions_to_responses_watson = Hash.new
			@@actions_to_responses_patient = Hash.new

		    SprainedAnkleGame.initilize_actions()
			SprainedAnkleGame.initialize_states()
			SprainedAnkleGame.initialize_states_to_actions()
			SprainedAnkleGame.initialize_actions_to_response_narrator()
			SprainedAnkleGame.initialize_actions_to_response_nurse()
			SprainedAnkleGame.initialize_actions_to_response_watson()
			SprainedAnkleGame.initialize_actions_to_response_patient()
			SprainedAnkleGame.initialize_percent_per_action()
			SprainedAnkleGame.initialize_bad_response_to_state()
		  end

		  def self.initilize_actions()
		    # This is a mapping from a user action to an updated state.
		    @@actions['Yes'] = 'Name'
		    @@actions['Name'] = 'Get Situation'
		    @@actions['Get Situation'] = 'Examine'

		    @@actions['Examine'] = 'Injury Details'
		    @@actions['Injury Details'] = 'Move Ankle'
		    @@actions['Move Ankle'] = 'Diagnosis'

		    @@actions['Sprained ankle'] = 'Remedy'

		    # Special cases handled in controller.
		    @@actions['Rest'] = 'Special Case'
		    @@actions['Elevate Ankle'] = 'Special Case'
		    @@actions['Ice'] = 'Special Case'

		    @@actions['Remedy'] = 'Done'

		    # Result in the same state?
		    @@actions['Bad Response'] = ''
		  end

		  def self.initialize_states()
		    # This is a mapping from a state to a unique ID.
		    @@states['Start'] = 0
		    @@states['Name'] = 1
		    @@states['Get Situation'] = 2    
		    @@states['Examine'] = 3
		    @@states['Injury Details'] = 4
		    @@states['Move Ankle'] = 5
		    @@states['Diagnosis'] = 6
		    @@states['Remedy'] = 7
		    @@states['Done'] = 8
		  end

		  def self.initialize_actions_to_response_narrator()
		  	# This is a mapping from an action to a response message.
			@@actions_to_responses_narrator['Start'] = "<p>You've heard that a certain high powered businessman " +
			"is having an extended stay at Northwest General.</p> <p>He's the one that's responsible " +
			"for kicking your dog. It's time to give him a piece of your mind. </p><p> Of course, you're " +
			"gonna get nowhere just going into the hospital and demanding to see him. No, you'll have " +
			"to be more clever than that.</p> <p>You enter the first floor of the hospital. You've " +
			"picked up a white coat from a costume shop, swiped a stethoscope off some resident's desk, " +
			"and are equipped to the brim with the best bandaids $5 at CVS could buy.</p><p> Oh yeah, and " +
			"WATSON, you have him too.</p><p>You're ready.</p><h2>First Floor - Northwest Hospital</h2>"

			@@actions_to_responses_narrator['Remedy'] = "Correct! The patient does have a sprained " + 
			"ankle."

			@@actions_to_responses_narrator['Done'] = "You've completed level 1. Congratulations!"
		  end 

		  def self.initialize_actions_to_response_nurse()
		  	# This is a mapping from an action to a response message.
			@@actions_to_responses_nurse['Start'] = "<p>Hey you! You're new here, but the ER is overflowing, " +
			"could you take a look at this guy? I'm sure it'll only take a few seconds...</p>"
			@@actions_to_responses_nurse['Name'] = "<p>Awesome, thanks! What's your name by the way?</p>"
			@@actions_to_responses_nurse['Get Situation'] = "Thanks, #{@username}. <p class='xdelay'> " +
			"Hey, #{@username}! Get over here!</p>"
			@@actions_to_responses_nurse['Injury Details'] = "Ouch, that looks pretty bad."
			@@actions_to_responses_nurse['Remedy'] = "Great diagnosis, doc! Now let's offer the patient " +
			"some remedies for his sprained ankle."

			@@actions_to_responses_nurse['Done'] = "#{@username}, there's another patient on the next " +
			"floor that needs to see someone immediately, but all of the other doctors are busy, mind if " +
			"you give me a hand?"
		  end 

		  def self.initialize_actions_to_response_watson()
		  	# This is a mapping from an action to a response message.
			@@actions_to_responses_watson['Get Situation'] = "Wow, you've really gotten yourself in quite the " +
			"predicament there #{@username}. Well, I'll tell you what, getting revenge on the guy that " +
			"kicked your dog is a pretty admirable goal you got there. I'll make myself available to you. " +
			"Whenever you have a question, just ask me it and I'll try and grab some info for you. " +
			"You'll be able to navigate the hospital by telling me where you want to go, but of course " +
			"some locations aren't gonna be available until you get past certain people. Use your wit " +
			"and my knowledge to get past these obstacles and get yourself up to the 5th floor. I've " +
			"heard that's where he's staying. <p class='delay'>Psst, ask her what's wrong</p>"
			@@actions_to_responses_watson['Injury Details'] = "I'm not too sure that's a broken ankle. Why don't " +
			"you try asking him how he got this injury?"
			@@actions_to_responses_watson['Move Ankle'] = "Alright, that certainly doesn't sound like a broken " +
			"ankle."
			@@actions_to_responses_watson['Diagnosis'] = "<p>It's time to give a diagnosis. Make sure you " +
			"do this properly! </p> "

			@@actions_to_responses_watson['Remedy'] = "<p>If you have any questions about how to remedy " +
			"a sprained ankle, ask me!</p>"

			@@actions_to_responses_watson['Done'] = "Great job, partner! We make a good team!  I think " +
			"you've even convinced that nurse."
		  end 

		  def self.initialize_actions_to_response_patient()
		  	# This is a mapping from an action to a response message.
			@@actions_to_responses_patient['Start'] = ""
			@@actions_to_responses_patient['Name'] = ""
			@@actions_to_responses_patient[''] = ""
			@@actions_to_responses_patient['Get Situation'] = "OWWWWWW!"
			@@actions_to_responses_patient['Examine'] = "I don't know... That's why I came here. I think " +
			"I broke my ankle, it really hurts when I put pressure on it. "
			@@actions_to_responses_patient['Move Ankle'] = " I was playing basketball... I was going up for a " +
			"layup when I got hit and had to land really awkwardly."
			@@actions_to_responses_patient['Diagnosis'] = ""

			# These are the special cases.
			@@actions_to_responses_patient['Bad Response'] = ""

			@@actions_to_responses_patient['Done'] = "Thank you, Doc!"
		  end 

		  def self.initialize_states_to_actions()
		    # This is a mapping from a particular state to the valid actions.
		    @@states_to_actions['Start'] = ['Yes']
		    @@states_to_actions['Name'] = ['Get Situation']
		    @@states_to_actions['Get Situation'] = ['Get Situation']
		    @@states_to_actions['Examine'] = ['Examine']
		    @@states_to_actions['Injury Details'] = ['Injury Details']
		    @@states_to_actions['Move Ankle'] = ['Move Ankle']
		    @@states_to_actions['Diagnosis'] = ['Sprained ankle']
		    @@states_to_actions['Remedy'] = ['Done']
		    @@states_to_actions['Done'] = []
		  end

		  def self.initialize_percent_per_action()
		  	# This is a mapping from a particular action to a percent.
		  	@@percent_per_action['Yes'] = 2.5
		  	@@percent_per_action['Name'] = 2.5

			@@percent_per_action['Get Situation'] = 5
			@@percent_per_action['Examine'] = 5

			@@percent_per_action['Injury Details'] = 10
			@@percent_per_action['Move Ankle'] = 10

			@@percent_per_action['Sprained ankle'] = 35

			@@percent_per_action['Rest'] = 10
			@@percent_per_action['Elevate Ankle'] = 10
			@@percent_per_action['Ice'] = 10

			@@percent_per_action['Bad Response'] = -10
		  end

		  def self.initialize_bad_response_to_state()
		  	@@bad_response_to_state['Start'] = "Oh c'mon! Let's play doctor."
		  	@@bad_response_to_state['Examine'] = "If you're going to be a doctor, you should probably " +
		  	"start by seeing what is wrong with your patient!"
		  	@@bad_response_to_state['Injury Details'] = "That's not what you should be doing right " +
		  	"now... You'll get caught if you don't act like a real doctor"
		  	@@bad_response_to_state['Move Ankle'] = "Wrong move! Act like a real doctor!"
		  	@@bad_response_to_state['Diagnosis'] = "Ask Watson about common ankle injuries to " +
		  	"diagnosis this patient."

		  	# Special case!
		  	@@bad_response_to_state['Remedy'] = ""
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

		  def set_remedy_value(action)
		  	if action == "Rest"
		  		if @remedy_values[0] == 1 
		  			@game_output << "You've already suggested to rest. Any other suggestions?"
		  		else
		  			@remedy_values[0] = 1
		  			@game_output << "Okay, what's next?"
		  		end
		  	elsif action == "Elevate Ankle"
		  		if @remedy_values[1] == 1
		  			@game_output << "You've already suggested to elevate ankle. Any other suggestions?"
		  		else
		  			@remedy_values[1] = 1
		  			@game_output << "What else can I do?"	
		  		end
		  	else action == "Ice"
		  		if @remedy_values[2] == 1
		  			@game_output << "You've already suggested to elevate ankle. Any other suggestions?"
		  		else 
		  			@remedy_values[2] = 1
		  			@game_output << "Okay, anything else?"
		  		end
		  	end
		  end

		  def move_to_done_state?()
		  	return @remedy_values.reduce(0, :+) == 3
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
