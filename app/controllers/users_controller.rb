require 'bcrypt'
include SessionsHelper
class UsersController < ApplicationController
    def new
        if logged_in?
            render 'users/home'
        else
            @user = User.new
        end
      end

    def create
        @err = nil
        @user = User.create(params[:user].permit(:first_name, :last_name, :email, :zip_code, :password, :password_confirmation))
        if !@user.save
            @err = @user.errors.messages
            @user = User.new
            render '/users/new'
        else
            log_in @user
            render '/users/home'
        end
    end

    def home
        unless logged_in?
            render layout: 'home'
            render '/sessions/new'
        end
    end
end
