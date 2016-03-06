require 'net/http'
require 'uri'
require 'json'
include SessionsHelper
include ApplicationHelper

class GamesController < ApplicationController
  @user_percent = 50

  def index
    render :layout => 'application'
    @games = current_user.games
  end

  def new
    render :layout => 'application'
    end_game
    @game = Game.new
  end

  def load
    render :layout => 'application'
    end_game
    @games = current_user.games
  end

  def create
    render :layout => 'games'
    @err = nil
    #@game =  Game.create(params[:game].permit(:name, :time, :user_id))

    if params[:loaded_game_id] == nil
      @game = Game.new(name: params[:name], time: 0, user_id: params[:user_id])
      if !@game.save
        @err = @game.errors.messages
        render '/games/new'
        return
      end

    else

      @game = Game.find(params[:loaded_game_id])
    end

    start_game (@game)

    @conversations = current_game.conversations
    render '/games/query'

    #@err = user.errors.messages
    #@game = Game.new
  end

  def query
    render :layout => 'games'
    user_input = params[:query]
  	answer = query_watson(user_input)

  	if answer
  		Conversation.create(query: user_input, response: answer, confidence: nil,
        game_id: params[:game_id])
  	end

  	@conversations = current_game.conversations
  	current_game.save
    end
end
