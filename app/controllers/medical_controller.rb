class MedicalController < ApplicationController
  include MedicalHelper
  @@medical_game = Gamestate.new('Emergency Room')
  @user_input = Array.new

  def index
	user_input = params[:query].to_s

  	if user_input.empty?
  		# This is the first time the index page is being loaded (i.e., there is no user input).
		response = @@medical_game.get_response_by_action('Initial phrase')
		@@medical_game.set_game_output(response)

	else
		@@medical_game.set_game_output(user_input)

		user_state = @@medical_game.get_updated_state(user_input)
		@@medical_game.set_game_output(user_state)
    	# if (@@demo_game.hasMultimedia) @@demo_game.set_game_output(someMultimediaString)

		#response = @@medical_game.get_response_by_state()
    #@@medical_game.set_game_output(response)
    actionResponse = @@medical_game.get_response_by_action(user_input)
    @@medical_game.set_game_output(actionResponse)


  	end
	@game_output = @@medical_game.get_game_output()
  end

  def new_game
	@@medical_game = Gamestate.new('Emergency Room')
	@user_input = Array.new

	redirect_to action: 'index'
  end

end
