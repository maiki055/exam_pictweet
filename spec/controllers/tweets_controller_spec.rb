require 'rails_helper'

describe TweetsController, type: :controller do
  describe 'GET #index' do
    it 'returns tweets order by created_at DESC' do
      tweet1 = create(:tweet)
      tweet2 = create(:tweet)
      get :index
      expect(assigns(:tweets)).to match([tweet1, tweet2])
    end

    it 'renders the :index template and 200' do
      get :index
      expect(response).to render_template :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #new' do
    it 'renders the :new template and 200' do
      get :new
      expect(response).to render_template :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    it 'create new tweet' do
      login_user
      expect{
        post :create, tweet: attributes_for(:tweet)
      }.to change(Tweet, :count).by(1)
    end

    it 'renders the :create template and return 200' do
      login_user
      post :create, tweet: attributes_for(:tweet)
      expect(response).to render_template :create
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE #destory' do
    it 'destory tweet' do
      login_user
      tweet = create(:tweet, user: subject.current_user)
      expect{
        delete :destroy, id: tweet
      }.to change(Tweet, :count).by(-1)
    end

    it 'renders the :destroy template and return 200' do
      login_user
      tweet = create(:tweet, user: subject.current_user)
      delete :destroy, id: tweet
      expect(response).to render_template :destroy
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested tweet to @tweet' do
      tweet = create(:tweet)
      get :edit, id: tweet
      expect(assigns(:tweet)).to eq tweet
    end

    it 'renders the :edit template and return 200' do
      tweet = create(:tweet)
      get :edit, id: tweet
      expect(response).to render_template :edit
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT #update' do
    it '' do
      login_user
      tweet = create(:tweet, user: subject.current_user)
      patch :update, id: tweet, text: 'tweet'
      tweet.reload
      expect(tweet.text).to eq('tweet')
    end

    it 'renders the :update template and return 200' do
      login_user
      tweet = create(:tweet, user: subject.current_user)
      put :update, id: tweet
      expect(response).to render_template :update
      expect(response.status).to eq(200)
    end
  end
end