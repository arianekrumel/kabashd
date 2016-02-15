class DemoController < ApplicationController
  include DemoHelper
  @@demo_game = DemoGame.new('Start')
  @user_input = Array.new

  def index
	user_input = params[:query].to_s

  	if user_input.empty?
  		# This is the first time the index page is being loaded (i.e., there is no user input).
		response = @@demo_game.get_response_by_state()
		@@demo_game.set_game_output(response)
	else
		@@demo_game.set_game_output(user_input)

		user_state = @@demo_game.get_updated_state(user_input)
		@@demo_game.set_game_output(user_state)

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
