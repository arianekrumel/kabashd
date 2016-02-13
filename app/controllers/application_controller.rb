class ApplicationController < ActionController::Base
  helper_method :isValidAction
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def isValidAction(gameState, action)
     splitIndex = action.index(',')
     keyword = action

     #take first word from list of recognized commands and remove white space
     if splitIndex!= nil
       keyword = action[0, splitIndex]
       keyword = keyword.strip
     end
     print keyword

     # only create if statements for invalid actions, assume all other actions
     # are valid in order to save space

    return 1
  end
end
