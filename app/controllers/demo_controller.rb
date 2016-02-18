class DemoController < ApplicationController
  include DemoHelper
  @@demo_game = DemoGame.new('Start')
  @user_input = Array.new
  @percent  = "";

  def index
	user_input = params[:query].to_s

  	if user_input.empty?
  		@percent = 10
  		# This is the first time the index page is being loaded (i.e., there is no user input).
		response = @@demo_game.get_response_by_state()
		@@demo_game.set_game_output(response)
	else
		@@demo_game.set_game_output(user_input)

		user_state = @@demo_game.get_updated_state(user_input)
		if(user_state.eql?"Action: Go to kitchen has been performed.")
  			@percent = 25
  		elsif(user_state.eql?"Action: Wash dishes has been performed.")
			@percent = 55
  		elsif(user_state.eql?"Action: Open the fridge has been performed.")
			@percent = 65
		elsif(user_state.eql?"Action: Go to bedroom has been performed.")
  			@percent = 75
		elsif(user_state.eql?"Action: Lay in bed has been performed.")
  			@percent = 100
  		else
  			@percent = 10
  		end
		@@demo_game.set_game_output(user_state)
    	# if (@@demo_game.hasMultimedia) @@demo_game.set_game_output(someMultimediaString)

		response = @@demo_game.get_response_by_state()
		@@demo_game.set_game_output(response)
  	end
	@game_output = @@demo_game.get_game_output()
  end

  def new_game
	@@demo_game = DemoGame.new('Start')
	@user_input = Array.new

	redirect_to action: 'index'
  end
end
