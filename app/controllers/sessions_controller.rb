require 'sessions_helper'

class SessionsController < ApplicationController
  def new
  end

  #validates log in information that is given by a user
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    @err = nil

    #if the information is valid, log the user in and redirect them to their homepage
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      render '/users/home'

      #otherwise notify error that the value is invalid and print it to the log in page
    else
      #user info is incorrect
      @err = 'Invalid email/password combination'
      redirect_to '/sessions/new'
    end

  end

  def destroy
    log_out
    redirect_to 'users/new'
  end
end
