require 'rails_helper'

RSpec.describe GameSessionsController, type: :controller do
  let(:user) { create(:user) }
  let!(:game_session) { create(:game_session, user: user) }

  before { sign_in(user) }

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { user_id: user.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the game session' do
      get :show, params: { user_id: user.id }
      expect(assigns(:game_session)).to eq(game_session)
    end
  end

  describe 'POST #roll' do
    it 'rolls the game session' do
      post :roll, params: { user_id: user.id }
      expect(assigns(:roll_result)).to be_an(Array)
    end

    it 'renders the show template' do
      post :roll, params: { user_id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #cash_out' do
    it 'calls the cash_out method on the user' do
      allow(controller).to receive(:current_user).and_return(user)

      expect(controller.current_user).to eq(user)
      expect(controller).to be_user_signed_in

      expect(user).to receive(:cash_out)

      post :cash_out, params: { user_id: user.id }
    end

    it 'signs out the user' do
      post :cash_out, params: { user_id: user.id }
      expect(controller).to_not be_user_signed_in
    end

    it 'redirects to the root path' do
      post :cash_out, params: { user_id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
