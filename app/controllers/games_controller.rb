require 'sessions_helper'

class GamesController < ApplicationController
  def new
   @game = Game.new
   @games = current_user.games

  end

  def create
    @err = nil

    if !game_started?
      @game =  Game.create(params[:game].permit(:name, :time, :user_id))
      start_game(@game)

        #@err = user.errors.messages
        #@game = Game.new

    end

    @conversation = Conversation.new

    render 'games/index'

  end


  def index
    @conversations = current_game.conversations
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
        #Conversation.create(query: params[:conversation][:query], confidence: answer[1], user_id: params[:conversation][:game_id])

        Conversation.create(query: params[:query], response: answer["text"], confidence: answer["value"], game_id: params[:game_id])
      end
    end
    @conversations = current_game.conversations
  end
end

