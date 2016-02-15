require 'net/http'
require 'uri'
require 'json'
require 'Gamestate.rb'

class HomeController < ApplicationController

  def index
  end

  def play
    Conversation.delete_all
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
        Conversation.create(query: params[:query], response: answer["text"], confidence: answer["value"])
        if isValidAction(Gamestate.getState("Location"), answer["text"])
         #give appropriate response to user
         print "State Approved"
        end
      end
    end
    @conversations = Conversation.all
  end

end
