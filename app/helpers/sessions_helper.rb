module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end
  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    return @current_user
  end

  def start_game(game)
    session[:game_id] = game.id
  end

  def current_game
    @current_game ||= Game.find_by(id: session[:game_id])
    return @current_game
  end
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def game_started?
    !current_game.nil?
  end
  #Logs the current user out
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def end_game
    session.delete(:game_id)
    @current_game = nil
  end
end
