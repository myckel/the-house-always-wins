require 'rails_helper'

RSpec.describe GameSession, type: :model do
  let(:user) { create(:user) }

  describe '#roll' do
    context 'when user has less than 40 credits' do
      let(:game_session) { create(:game_session, user: user) }

      it 'generates a truly random result' do
        result = game_session.roll
        expect(result).to be_an(Array)
        expect(result).to all(be_in(%w[C L O W]))
      end
    end

    context 'when user has between 40 and 60 credits' do
      let(:game_session) { create(:game_session, :with_credits_40_to_60, user: user) }

      it 'may re-roll the round with a 30% chance' do
        allow(game_session).to receive(:should_reroll?).and_return(true)

        result = game_session.roll
        expect(result).to be_an(Array)
        expect(result).to all(be_in(%w[C L O W]))
      end

      it 'does not re-roll the round with a 70% chance' do
        allow(game_session).to receive(:should_reroll?).and_return(false)

        result = game_session.roll
        expect(result).to be_an(Array)
        expect(result).to all(be_in(%w[C L O W]))
      end
    end

    context 'when user has above 60 credits' do
      let(:game_session) { create(:game_session, :with_credits_above_60, user: user) }

      it 'may re-roll the round with a 60% chance' do
        allow(game_session).to receive(:should_reroll?).and_return(true)

        result = game_session.roll
        expect(result).to be_an(Array)
        expect(result).to all(be_in(%w[C L O W]))
      end

      it 'does not re-roll the round with a 40% chance' do
        allow(game_session).to receive(:should_reroll?).and_return(false)

        result = game_session.roll
        expect(result).to be_an(Array)
        expect(result).to all(be_in(%w[C L O W]))
      end
    end

    context 'when user has no credits' do
      let(:game_session) { create(:game_session, user: user, credits: 0) }

      it 'does not perform a roll and shows an error' do
        expect(game_session.roll).to be_nil
        expect(game_session.errors[:credits]).to include("must have at least 1 credit to roll")
      end
    end

    context 'when user has credits' do
      let(:game_session) { create(:game_session, user: user, credits: 100) }

      it 'decrements the credits by 1 per roll' do
        expect { game_session.roll }.to change { game_session.credits }.by(GameSession::PER_PULL)
      end
    end

    context 'when there is a winner' do
      let(:game_session) { create(:game_session, user: user, credits: 100) }

      it 'increments the credits if there is a winner' do
        allow(game_session).to receive(:generate_result).and_return(['C', 'C', 'C'])
        expect {
          game_session.roll
        }.to change { game_session.credits }.by(GameSession::PRIZES['C'] + GameSession::PER_PULL)
      end
    end

    context 'when there is no winner' do
      let(:game_session) { create(:game_session, user: user, credits: 100) }

      it 'does not increment the credits if there is no winner' do
        allow(game_session).to receive(:generate_result).and_return(['C', 'C', 'O'])
        expect {
          game_session.roll
        }.to change { game_session.credits }.by(GameSession::PER_PULL)
      end
    end
  end

  describe '#enough_credits_to_roll' do
    context 'when user has no credits' do
      let(:game_session) { create(:game_session, user: user, credits: 0) }

      it 'returns false' do
        expect(game_session.send(:enough_credits_to_roll)).to be false
      end
    end

    context 'when user has credits' do
      let(:game_session) { create(:game_session, user: user, credits: 100) }

      it 'returns true' do
        expect(game_session.send(:enough_credits_to_roll)).to be true
      end
    end
  end
end
