require 'net/http'
require 'uri'
require 'json'
include SessionsHelper
include ApplicationHelper
include GamesHelper
class GamesController < ApplicationController
    layout = 'games'
    @@levelNumbers = {}

    def index
        @games = current_user.games
        render layout: 'application'
    end

    def new
        end_game
        @game = Game.new
        render layout: 'application'
    end

    def load
        end_game
        @games = current_user.games
        render layout: 'application'
    end

    def create
        @@goal = nil
        @@keys = Set.new
        @@repeats = {}
        @err = nil
        gamestate = GameState.first
        @@level = gamestate.level
        if params[:loaded_game_id].nil?
            @game = Game.new(game_state_id: gamestate.id, name: params[:name], time: 0, user_id: params[:user_id], info: 'No information to display')
            unless @game.save
                @err = @game.errors.messages
                render '/games/new'
                return
            end

        else
            @game = Game.find(params[:loaded_game_id])
        end

        start_game @game

        @conversations = current_game.conversations
        render '/games/query'
    end

    def query
        input = params[:query]

        gamestate = GameState.find(current_game.game_state_id)

        @@repeats = {} if @@level != gamestate.level
        parseGoal(gamestate.goalActions, gamestate.keys)

        if params[:tag] == 'Story'

            parseAction(input, gamestate.saveValue)
        else
            current_game.info = query_watson(input, 'Knowledge')
        end

        @conversations = current_game.conversations
        current_game.save
    end

    # #HELPERS##

    def parseGoal(goalActions, keysets)
        @@goal = goalActions.split(', ')

        if !keysets.nil? && @@keys.empty?
            keysets = keysets.split('), (')
            for keyset in keysets
                keyset = keyset.tr('()', '').split(', ')
                temp = {}
                for key in keyset
                    temp[key] = false
                end
                print(temp)
                print("\n\n")
                @@keys.add(temp)
            end
        end
    end

    def parseAction(input, saveValue)
        if !saveValue.nil?
            current_game[saveValue] = input.titleize
            action = @@goal[0]
        else
            action = query_watson(input, 'Story')
            if @@repeats.key?(action)
                Conversation.create(query: input, response: @@repeats[action], confidence: nil, game_id: current_game.id)
                return
            end
        end

        goalIndex = 0
        for keyset in @@keys

            unless keyset[action].nil?
                if keyset[action] == true
                    break
                else
                    keyset[action] = true
                    goal = true
                    keyset.each do |_key, value|
                        print value
                        goal = false unless value
                    end
                    print("\n")

                    if goal
                        processResponse(action, input, current_game.id)
                        action = @@goal[goalIndex]
                        input = ''
                        break
                    end
                end
            end

            goalIndex += 1
        end

        processResponse(action, input, params[:game_id])
        for goal in @@goal

            next unless action == goal
            @@goal = nil
            @@keys = Set.new

            break

        end
    end

    def processResponse(answer, user_input, gameID)
        gamestate = current_game.game_state
        action = gamestate.actions.where(['command = ?', answer]).first

        if action
            current_game.score += action.score_reward
            current_game.progress += action.progress_reward
            unless action.repeatResponse.nil?
                if action.repeatResponse == 'default'
                    @@repeats[action.command] = action.response
                else
                    @@repeats[action.command] = action.repeatResponse
                end
            end
            Conversation.create(query: user_input, response: action.response.gsub('%n', current_game.player_name), confidence: nil,
                                game_id: gameID, image: action.image)
            current_game.game_state_id = action.result_state_id
            lvl = current_game.game_state.level
            unless @@levelNumbers.key?(lvl)
                @@levelNumbers[lvl] = @@levelNumbers.size + 1
            end
            current_game.level_num = @@levelNumbers[lvl]

        else
            action = nil
            actions = Action.all.where(['command = ?', answer])
            for temp in actions
                if GameState.find(temp.start_state_id).level == gamestate.level
                    action = temp
                    break
                end
            end
            print action
            if action && !action.earlyResponse.nil?
                Conversation.create(query: user_input, response: action.earlyResponse, confidence: nil, game_id: gameID)
            else
                Conversation.create(query: user_input, response: "Sorry, you can't do that right now.", confidence: nil, game_id: gameID)
            end
           end
    end
end
