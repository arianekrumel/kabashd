class LymeDiseaseController < ApplicationController
	include LymeDiseaseHelper

	@@lyme_disease_game = LymeDiseaseGame.new('Start')
	@watson_question_output = ""
	user_state = ""


  def index()
	# @username = @@lyme_disease_game.get_username()
	user_input = params[:query].to_s
	watson_response = ""
	user_state = @@lyme_disease_game.get_user_state()

	# User has asked Watson a question.
	if params[:question] and not params[:question].empty?
		user_input = params[:question].to_s
		@game_output = @@lyme_disease_game.get_game_output()
		@watson_output =  @@lyme_disease_game.get_watson_output()
  		@watson_question_output = query_watson(user_input)[1]
  		@watson_output << "<p> Watson's Brain <p> <div class='card'>#{@watson_question_output}></div>"

		return
	end

	# User has entered a command. Disambiguate this command by sending it to Watson.
	if not user_input.empty?
  		watson_response = query_watson(user_input)[0]
  	end

  	# Set the percentage and then retrieve it.
	@@lyme_disease_game.set_percent_per_action(watson_response)
	@user_percent = @@lyme_disease_game.get_percent_per_action()

  	if watson_response.nil? 
  		# Watson did not return any documents.
  		@watson_output = Array.new
		@watson_output << "WATSON RETURNS NIL :(. - No Ka-bash'd documents..."
	elsif watson_response.empty? and user_state == "Start"
  		# This is the first time the index page is being loaded (i.e., there is no user input).
		@@lyme_disease_game.get_all_responses()
	else
		@watson = watson_response
		@@lyme_disease_game.set_game_output("You <div class='card'>" + user_input + "</div>")
		user_state = @@lyme_disease_game.get_updated_state(watson_response)

		if user_state
			@updates = user_state
			@@lyme_disease_game.get_all_responses(user_state)
		else
			# Bad Response. Get the appropriate response.
			@@lyme_disease_game.set_bad_response(@@lyme_disease_game.get_user_state())
		end
  	end

	@game_output = @@lyme_disease_game.get_game_output()
	@watson_output =  @@lyme_disease_game.get_watson_output()
  end

  def new_game
  	# Restarts the game.
	@@lyme_disease_game = LymeDiseaseGame.new('Start')
	@user_input = Array.new

	redirect_to action: 'index'
  end
end
