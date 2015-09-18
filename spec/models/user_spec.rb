require 'rails_helper'

describe User, type: :model do
  describe 'validation' do
    it 'is invalid without a nickname' do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it 'is invalid without a email' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid without a password' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is invalid when nickname length more than 6' do
      user1 = build(:user, nickname: Faker::Internet.user_name(6..6))
      expect(user1).to be_valid

      user2 = build(:user, nickname: Faker::Internet.user_name(7..7))
      user2.valid?
      expect(user2.errors[:nickname]).to include('is too long (maximum is 6 characters)')
    end

    it 'is invalid with a duplicate email address' do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      user2.valid?
      expect(user2.errors[:email]).to include('has already been taken')
    end
  end

  describe '#count_tweets' do
    let(:user) { create(:user) }
    before do
      3.times{ create(:tweet, user: user) }
    end
    it 'returns 3' do
      expect(user.count_tweets).to be 3
    end
  end
end
