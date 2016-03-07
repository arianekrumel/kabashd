class SprainedAnkleController < ApplicationController
  include SprainedAnkleHelper

  @@sprained_ankle_game = SprainedAnkleGame.new('Start')
  $username
  @watson_question_output = ""
  user_state = ""

  def index()
	user_input = params[:query].to_s
	watson_response = ""
	user_state = @@sprained_ankle_game.get_user_state()

	if params[:question] and not params[:question].empty?
		user_input = params[:question].to_s
		@game_output = @@sprained_ankle_game.get_game_output()
		@watson_output =  @@sprained_ankle_game.get_watson_output()
  		@watson_question_output = query_watson(user_input)[1]
  		@watson_output << "<p> Watson's Brain <p> <div class='card'>#{@watson_question_output}></div>"

		return
	end

	if not user_input.empty? and not user_state == "Name"
  		watson_response = query_watson(user_input)[0]
  	end

	@@sprained_ankle_game.set_percent_per_action(watson_response)
	@user_percent = @@sprained_ankle_game.get_percent_per_action()

  	if watson_response.nil? 
  		@watson_output = Array.new
		@watson_output << "WATSON RETURNS NIL :(. - No Ka-bash'd documents..."
	elsif user_state == "Name"
		# Transition to the NAME state without checking validity of action.
		@@sprained_ankle_game.set_game_output("You <div class='card'>" + user_input + "</div>")
		@@sprained_ankle_game.set_percent_per_action(user_state)
		@user_percent = @@sprained_ankle_game.get_percent_per_action()

		$username = user_input
		user_state = @@sprained_ankle_game.updated_state(user_state)

		@updates = user_state
		@@sprained_ankle_game.get_all_responses(user_state)

		# @game_output = @@sprained_ankle_game.get_game_output()
		# @game_output << watson_response
		# @watson_output =  @@sprained_ankle_game.get_watson_output()
	elsif watson_response.empty?
  		# This is the first time the index page is being loaded (i.e., there is no user input).
		@@sprained_ankle_game.get_all_responses()
	elsif user_state == "Remedy"
		@@sprained_ankle_game.set_game_output("You <div class='card'>" + user_input + "</div>")
		@@sprained_ankle_game.set_remedy_value(watson_response)
		if @@sprained_ankle_game.move_to_done_state?
			user_state = @@sprained_ankle_game.updated_state(user_state)
			@@sprained_ankle_game.get_all_responses(user_state)
		end
	else
		@watson = watson_response
		@@sprained_ankle_game.set_game_output("You <div class='card'>" + user_input + "</div>")
		user_state = @@sprained_ankle_game.get_updated_state(watson_response)

		if user_state
			@updates = user_state
			@@sprained_ankle_game.get_all_responses(user_state)
		else
			# Bad Response. Get the appropriate response.
			@@sprained_ankle_game.set_bad_response(@@sprained_ankle_game.get_user_state())
		end
  	end

	@game_output = @@sprained_ankle_game.get_game_output()
	@watson_output =  @@sprained_ankle_game.get_watson_output()
  end

  def new_game
	@@sprained_ankle_game = SprainedAnkleGame.new('Start')
	@user_input = Array.new

	redirect_to action: 'index'
  end
end
