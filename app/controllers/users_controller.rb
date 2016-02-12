require 'bcrypt'
require 'sessions_helper'

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @err = nil
    user =  User.create(params[:user].permit(:first_name, :last_name, :email, :zip_code, :password, :password_confirmation))
    if !user.save
      @err = user.errors.messages
      user = User.new
      render '/users/new'
    else
      render '/sessions/new'
    end
  end

  def login
    permitted = params.require(:user).permit(:email, :first_name)
    user = User.find_by_email(params[:user]["email"].downcase)
    @err = nil

    #if the information is valid, log the user in and redirect them to their homepage
    if user && user.authenticate(params[:user]["password"])
      log_in user
      @user_first = user.first_name.
      render 'users/home'

      #otherwise notify error that the value is invalid and print it to the log in page
    else
      #user info is incorrect
      @err = 'Invalid email/password combination'
      render '/sessions/new'
    end
  end

  def home
    def home
      if !logged_in?
        redirect_to login_path
      else
        #otherwise, store the user's entry that is currently logged in
      end
    end
  end
end
