class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Relationships
  has_one :game_session, dependent: :destroy
  has_one :credits, class_name: 'Credit', dependent: :destroy, foreign_key: 'user_id'

  # Constants
  INITIAL_CREDITS = 10

  # Callbacks
  after_create :create_initial_data

  # Instance Methods

  # Set up the user's game session
  def set_session
    amount = credits.amount
    amount = INITIAL_CREDITS unless amount.positive?
    create_game_session(credits: amount)
  end

  # Cash out the user's credits and destroy the game session
  def cash_out
    credits.update(amount: game_session.credits)
    game_session.destroy
  end

  private

  # Create initial data for the user (credits)
  def create_initial_data
    create_credits(amount: INITIAL_CREDITS)
  end
end
