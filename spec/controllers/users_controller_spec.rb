require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #show' do
    it '@nickname equal current_user.nickname' do
      login_user
      user =  subject.current_user
      get :show, id: user
      expect(assigns(:nickname)).to eq(user.nickname)
    end

    it "returns current_user's tweets" do
      login_user
      user = subject.current_user
      tweet1 = create(:tweet, user: user)
      tweet2 = create(:tweet, user: user)
      get :show, id: user
      expect(assigns(:tweets)).to match([tweet1, tweet2])
    end

    it "returns current_user's tweets count" do
      login_user
      user = subject.current_user
      tweet1 = create(:tweet, user: user)
      tweet2 = create(:tweet, user: user)
      get :show, id: user
      expect(assigns(:tweets_count)).to be 2
    end

    it 'renders the :get template and return 200' do
      login_user
      user =  subject.current_user
      get :show, id: user
      expect(response).to render_template :show
      expect(response.status).to eq(200)
    end
  end
end
