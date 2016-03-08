class DemoController < ApplicationController
  include DemoHelper
  @@demo_game = DemoGame.new('Start')
  @watson_question_output = ""
  user_state = ""


    def index()
  	@username = @@demo_game.get_username()
  	user_input = params[:query].to_s
  	watson_response = ""
  	user_state = @@demo_game.get_user_state()

  	if params[:question] and not params[:question].empty?
  		user_input = params[:question].to_s
  		@game_output = @@demo_game.get_game_output()
  		@watson_output =  @@demo_game.get_watson_output()
    		@watson_question_output = user_input
    		@watson_output << "<p> Watson's Brain <p> <div class='card'>#{@watson_question_output}></div>"

  		return
  	end

  	if not user_input.empty? and not user_state == "Name"
    		watson_response = user_input
    	end

  	@@demo_game.set_percent_per_action(watson_response)
  	@user_percent = @@demo_game.get_percent_per_action()

    	if watson_response.nil?
    		@watson_output = Array.new
  		@watson_output << "WATSON RETURNS NIL :(. - No Ka-bash'd documents..."
  	elsif user_state == "Name"
  		# Transition to the NAME state without checking validity of action.
  		@@demo_game.set_game_output("You <div class='card'>" + user_input + "</div>")
  		@@demo_game.set_percent_per_action(user_state)
  		@user_percent = @@demo_game.get_percent_per_action()

  		@@demo_game.set_username(user_input)
  		@username = @@demo_game.get_username()
  		user_state = @@demo_game.updated_state(user_state)

  		@updates = user_state
  		@@demo_game.get_all_responses(user_state)
  	elsif watson_response.empty? and user_state == "Start"
    		# This is the first time the index page is being loaded (i.e., there is no user input).
  		@@demo_game.get_all_responses()
  	elsif user_state == "Remedy"
  		@@demo_game.set_game_output("You <div class='card'>" + user_input + "</div>")
  		@@demo_game.set_remedy_value(watson_response)
  		if @@demo_game.move_to_done_state?
  			user_state = @@demo_game.updated_state(user_state)
  			@@demo_game.get_all_responses(user_state)
  		end
  	else
  		@watson = watson_response
  		@@demo_game.set_game_output("You <div class='card'>" + user_input + "</div>")
  		user_state = @@demo_game.get_updated_state(watson_response)

  		if user_state
  			@updates = user_state
  			@@demo_game.get_all_responses(user_state)
  		else
  			# Bad Response. Get the appropriate response.
  			@@demo_game.set_bad_response(@@demo_game.get_user_state())
  		end
    	end

  	@game_output = @@demo_game.get_game_output()
  	@watson_output =  @@demo_game.get_watson_output()
    end

  def new_game
	@@demo_game = DemoGame.new('Start')
	@user_input = Array.new

	redirect_to action: 'index'
  end
end
