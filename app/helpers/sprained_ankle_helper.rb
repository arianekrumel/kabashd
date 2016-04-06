module SprainedAnkleHelper
	include ApplicationHelper

	class SprainedAnkleGame < GameSkeleton
		def initialize(user_state)
		    @user_state = user_state
		    @game_output = Array.new
		    @percent = 0
		    @remedy_values = [0, 0, 0]
			@watson_output = Array.new
			@username

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

		    @@actions['Diagnose Sprained Ankle'] = 'Remedy'

		    # Special cases handled in controller.
		    @@actions['Rest'] = 'Special Case'
		    @@actions['Elevate Ankle'] = 'Special Case'
		    @@actions['Ice Ankle'] = 'Special Case'

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
			@@actions_to_responses_narrator['Start'] = "Narrator <div class='card' style='margin-bottom: " +
			"20px;'><p>You've heard that a certain high powered businessman is having an extended stay " +
			"at Northwest General.</p> <p>He's the one that's responsible for kicking your dog. It's time " +
			" to give him a piece of your mind. </p><p> Of course, you're gonna get nowhere just going " +
			"into the hospital and demanding to see him. No, you'll have to be more clever than that." +
			"</p> <p>You enter the first floor of the hospital. You've picked up a white coat from a " +
			"costume shop, swiped a stethoscope off some resident's desk, and are equipped to the brim " +
			"with the best bandaids $5 at CVS could buy.</p><p> Oh yeah, and WATSON, you have him too." +
			"</p><p>You're ready.</p></div>Location <div class='card' style='margin-top: 8px;'>" +
			"<p>First Floor - Northwest Hospital</p></div>"

			@@actions_to_responses_narrator['Injury Details'] = "Image <div class='card'><%= image_tag(" +
			"'SwollenAnkle.png', :alt => 'Image of injured ankle') %></div>"
			@@actions_to_responses_narrator['Move Ankle'] = "Image <div class='card'><%= " +
			"image_tag('failed_layup.gif', :alt => 'Gif of failed layup') %></div>"
			@@actions_to_responses_narrator['Diagnosis'] = "Image <div class='card'><%= image_tag(" +
			"'move_ankle.gif', :alt => 'Image of injured ankle') %></div>"
			@@actions_to_responses_narrator['Remedy'] = "Narrator <div class='card'>Correct! The patient " +
			"does have a sprained ankle.</div>"

			@@actions_to_responses_narrator['Done'] = "Narrator <div class='card'>You've completed level " +
			"1. Congratulations!</div>"
		  end

		  def self.initialize_actions_to_response_nurse()
		  	# This is a mapping from an action to a response message.
			@@actions_to_responses_nurse['Start'] = "Nurse <div class='card'><p>Hey you! You're new here, " +
			"but the ER is overflowing, could you take a look at this guy? I'm sure it'll only take a " +
			"few seconds...</p></div>"
			@@actions_to_responses_nurse['Name'] = "Nurse <div class='card'><p>Awesome, thanks! What's " +
			"your name by the way?</p></div>"
			@@actions_to_responses_nurse['Get Situation'] = "Nurse <div class='card'>Thanks, <%= @username %>. " +
			"<p class='xdelay'> Hey, <%= @username %>! Get over here!</p></div>"
			@@actions_to_responses_nurse['Injury Details'] = "Nurse <div class='card'>Ouch, that looks " +
			"pretty bad.</div>"
			@@actions_to_responses_nurse['Remedy'] = "Nurse <div class='card'>Great diagnosis, doc! Now let's " +
			"offer the patient some remedies for his sprained ankle.</div>"

			@@actions_to_responses_nurse['Done'] = "Nurse <div class='card'><%= @username %>, there's " +
			"another patient on the next floor that needs to see someone immediately, but all of the " +
			"other doctors are busy, mind if you give me a hand?</div>"
		  end

		  def self.initialize_actions_to_response_watson()
		  	# This is a mapping from an action to a response message.
			@@actions_to_responses_watson['Get Situation'] = "Watson <div class='card'>Wow, you've " +
			"really gotten yourself in quite the predicament there <%= @username %>. Well, I'll tell you " +
			"what, getting revenge on the guy that kicked your dog is a pretty admirable goal you got " +
			"there. I'll make myself available to you. Whenever you have a question, just ask me it and " +
			"I'll try and grab some info for you. You'll be able to navigate the hospital by telling me " +
			"where you want to go, but of course some locations aren't gonna be available until you get " +
			"past certain people. Use your wit and my knowledge to get past these obstacles and get " +
			"yourself up to the 5th floor. I've heard that's where he's staying. <p class='delay'>Psst, " +
			"ask her what's wrong</p></div>"
			@@actions_to_responses_watson['Injury Details'] = "Watson <div class='card'>I'm not too sure " +
			"that's a broken ankle. Why don't you try asking him how he got this injury?</div>"
			@@actions_to_responses_watson['Move Ankle'] = "Watson <div class='card'>Alright, that " +
			"certainly doesn't sound like a broken ankle.</div>"
			@@actions_to_responses_watson['Diagnosis'] = "Watson <div class='card'><p>It's time to " +
			"give a diagnosis. Make sure you do this properly! </p></div>"

			@@actions_to_responses_watson['Remedy'] = "Watson <div class='card'><p>If you have any " +
			"questions about how to remedy a sprained ankle, ask me!</p></div>"

			@@actions_to_responses_watson['Done'] = "Watson <div class='card'>Great job, partner! We " +
			"make a good team!  I think you've even convinced that nurse.</div>"
		  end

		  def self.initialize_actions_to_response_patient()
		  	# This is a mapping from an action to a response message.
			@@actions_to_responses_patient['Get Situation'] = "Patient <div class='card'>OWWWWWW!</div>"
			@@actions_to_responses_patient['Examine'] = "Patient <div class='card'>I don't know... " +
			"That's why I came here. I think I broke my ankle, it really hurts when I put pressure on " +
			"it.</div>"
			@@actions_to_responses_patient['Move Ankle'] = "Patient <div class='card'>I was playing " +
			"basketball... I was going up for a layup when I got hit and had to land really awkwardly.</div>"
			@@actions_to_responses_patient['Diagnosis'] = "Patient <div class='card'>What do you think " +
			"I have, doc?</div>"
			@@actions_to_responses_patient['Done'] = "Patient <div class='card'>Thank you, Doc!</div>"
		  end

		  def self.initialize_states_to_actions()
		    # This is a mapping from a particular state to the valid actions.
		    @@states_to_actions['Start'] = ['Yes']
		    @@states_to_actions['Name'] = ['Get Situation']
		    @@states_to_actions['Get Situation'] = ['Get Situation']
		    @@states_to_actions['Examine'] = ['Examine']
		    @@states_to_actions['Injury Details'] = ['Injury Details']
		    @@states_to_actions['Move Ankle'] = ['Move Ankle']
		    @@states_to_actions['Diagnosis'] = ['Diagnose Sprained Ankle']
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

			@@percent_per_action['Diagnose Sprained Ankle'] = 35

			@@percent_per_action['Rest'] = 10
			@@percent_per_action['Elevate Ankle'] = 10
			@@percent_per_action['Ice Ankle'] = 10

			@@percent_per_action['Bad Response'] = -10
		  end

		  def self.initialize_bad_response_to_state()
		  	@@bad_response_to_state['Start'] = "Bad Response <div class='card'>Oh c'mon! Let's play " +
		  	"doctor.</div>"
		  	@@bad_response_to_state['Get Situation'] = "Bad Response <div class='card'>If you're going to be a " +
		  	"doctor, you should probably start by seeing what is wrong with your patient!</div>"
		  	@@bad_response_to_state['Examine'] = "Bad Response: <div class='card'>Maybe you should " +
		  	"take a further look at this situation?</div>"
		  	@@bad_response_to_state['Injury Details'] = "Bad Response <div class='card'>That's not " +
		  	"what you should be doing right now... You'll get caught if you don't act like a real " +
		  	"doctor</div>"
		  	@@bad_response_to_state['Move Ankle'] = "Bad Response <div class='card'>Wrong move! Act " +
		  	"like a real doctor! Ask the patient to move his ankle.</div>"
		  	@@bad_response_to_state['Diagnosis'] = "Bad Response <div class='card'>Ask Watson about " +
		  	"common ankle injuries to diagnosis this patient.</div>"

		  	@@bad_response_to_state['Remedy'] = "Bad Response <div class='card'>Ask Waston about " +
		  	"remedies for sprained ankles!</div>"
		  end

		  def set_remedy_value(action)
		  	if action == "Rest"
		  		if @remedy_values[0] == 1
		  			@game_output << "Bad Response <div class='card'><p>You've already suggested to rest. " +
		  			" Any other suggestions?</p></div>"
		  		else
		  			@remedy_values[0] = 1
		  			if not @remedy_values.reduce(0, :+) == 3
		  				@game_output << "Patient <div class='card'><p>Okay, what's next?</p></div>"
		  			end
		  		end
		  	elsif action == "Elevate Ankle"
		  		if @remedy_values[1] == 1
		  			@game_output << "Bad Response <div class='card'><p>You've already suggested to elevate " +
		  			"ankle. Any other suggestions?</p></div>"
		  		else
		  			@remedy_values[1] = 1

		  			if not @remedy_values.reduce(0, :+) == 3
		  				@game_output << "Patient <div class='card'><p>What else can I do?</p></div>"
		  			end
		  		end
		  	else action == "Ice Ankle"
		  		if @remedy_values[2] == 1
		  			@game_output << "Bad Response <div class='card'><p>You've already suggested to add ice " +
		  			"Any other suggestions?</p></div>"
		  		else
		  			@remedy_values[2] = 1
		  			if not @remedy_values.reduce(0, :+) == 3
		  				@game_output << "Patient <div class='card'><p>Okay, anything else?</p></div>"
		  			end
		  		end
		  	end
		  end

		  def set_bad_response(state)
			@game_output << @@bad_response_to_state[state]
		  end

		  def move_to_done_state?()
		  	return @remedy_values.reduce(0, :+) == 3
		  end

		  def set_username(name)
		  	@username = name
		  end

		  def get_username()
		  	return @username
		  end
	end
end
