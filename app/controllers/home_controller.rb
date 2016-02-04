require 'net/http'
require 'uri'
require 'json'
class HomeController < ApplicationController
  def index

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
    puts response.as_json
    puts response.body.as_json

    @response = response.body.as_json

    render 'home/query'
  end
end
