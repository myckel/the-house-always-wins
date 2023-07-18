class GameSessionsController < ApplicationController
  before_action :set_game_session, except: [:cash_out]

  # GET /users/:user_id/game_session
  def show
  end

  # POST /users/:user_id/game_session/roll
  def roll
    # Roll the slot machine for the current game session
    @roll_result = @game_session.roll

    # Check if there are any errors related to credits
    if @game_session.errors[:credits].present?
      flash[:alert] = @game_session.errors[:credits].first
    end

    respond_to do |format|
      format.html { render :show }
      format.json { render json: { roll_result: @roll_result, credits: @game_session.credits } }
    end
  end

  # POST /users/:user_id/game_session/cash_out
  def cash_out
    # Cash out the current user and sign them out
    current_user.cash_out
    sign_out(current_user)

    # Redirect to the root path after cashing out
    redirect_to root_path
  end

  private

  def set_game_session
    # Set the game session for the current user
    @game_session = current_user.game_session
  end
end
