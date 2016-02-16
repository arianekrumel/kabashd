class User < ActiveRecord::Base

  before_save { self.email = self.email.downcase }
  before_save { self.first_name = self.first_name.to_s.titleize }

  #Requires that a first and last name of length 2-20 are present
  validates :first_name, :presence => true, :length => { :in => 2..20 }
  validates :last_name, :presence => true, :length => { :in => 2..20 }


  #Requires that a email is unique to all other entries and present
  validates :email, :presence => true, :uniqueness => true

  #Only on Create so other actions like update password attribute can be nil
  validates_length_of :password, :in => 6..20, :on => :create


  #Each User entry can be associated with several for-sale books and several wanted books
  has_many :games

  #Checks that given password is secure
  has_secure_password
end
