class Game < ActiveRecord::Base
  validates :name, :presence => true, :length => { :in => 3..20 }

  has_many :conversations
  belongs_to :user
end
