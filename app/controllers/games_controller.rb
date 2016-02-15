require 'net/http'
require 'uri'
require 'json'
require 'Gamestate.rb'
include SessionsHelper

class GamesController < ApplicationController

  def index
    @games = current_user.games
  end

  def new
    if game_started?
      end_game
      end
    @games = current_user.games
  end

  def load
    if game_started?
      end_game
    end
    @games = current_user.games
  end

  def create
    @err = nil
    #@game =  Game.create(params[:game].permit(:name, :time, :user_id))

    if params[:game_id] == nil
      @game = Game.create(name: params[:name], time: 0, user_id: params[:user_id], created_at: params[:created_at])
      start_game(@game)
    else
      @game = Game.find(params[:game_id])
      start_game (@game)
    end


    #@err = user.errors.messages
    #@game = Game.new

    @conversation = Conversation.new
    @conversations = current_game.conversations


    render 'games/query'

  end

  def query
    url = 'https://dal09-gateway.watsonplatform.net/instance/579/deepqa/v1/question'
    uri = URI(url)

    request = Net::HTTP::Post.new(uri.path)
    request['Accept'] = 'application/json'
    request['X-SyncTimeout'] = 30
    request['Data-Type'] = 'json'
    request['Content-Type'] = 'application/json'

    request.body = { "question" => {"questionText" => params[:query].to_s}}.to_json
    request.basic_auth("osu2_student18", "4kT7XGAo")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.request(request)
    puts response.body.as_json

    jsonResponse = JSON.parse(response.body.as_json)["question"]
    if jsonResponse != nil
      listAnswers = jsonResponse["evidencelist"]
      if listAnswers.size > 0
        answer = listAnswers[0]
        Conversation.create(query: params[:query], response: answer["text"], confidence: answer["value"], game_id: params[:game_id])
        if isValidAction(Gamestate.getState("Location"), answer["text"])
         #give appropriate response to user
         print "State Approved"
        end
      end
    end
    @conversations = current_game.conversations
    @current_game.save
  end

end
