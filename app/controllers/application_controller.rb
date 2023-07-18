class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    # Set the game session for the current user
    @game_session = current_user.set_session

    # Redirect to the user's game session page
    user_game_session_path(current_user, @game_session)
  end
end
