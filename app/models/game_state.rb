class GameState < ActiveRecord::Base
    has_many :actions, class_name: 'Action', foreign_key: 'start_state_id'
    has_many :games
end
