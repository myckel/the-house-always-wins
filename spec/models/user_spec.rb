require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#set_session' do
    let(:user) { create(:user) }

    it 'creates a game session with the user credits amount' do
      user.set_session

      expect(user.game_session).to be_present
      expect(user.game_session.credits).to eq(user.credits.amount)
    end
  end

  describe '#cash_out' do
    let(:user) { create(:user) }

    it 'updates the credits amount and destroys the game session' do
      game_session = create(:game_session, user: user)
      user.cash_out

      expect(user.credits.amount).to eq(game_session.credits)
      expect(GameSession.exists?(game_session.id)).to be_falsey
    end
  end
end
