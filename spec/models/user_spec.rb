require 'rails_helper'

describe User, type: :model do
  it 'is invalid without a nickname' do
    user = User.new()
    user.valid?
    expect(user.errors[:nickname]).to include("can't be blank")
  end

  it 'is invalid without a email' do
    user = User.new()
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without a password' do
    user = User.new()
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid when nickname length more than 6' do
    user1 = User.new(
      nickname: '123456',
      email: 'test@we-b.co.jp',
      password: 'password'
    )
    expect(user1).to be_valid

    user2 = User.new(
      nickname: '1234567'
    )
    user2.valid?
    expect(user2.errors[:nickname]).to include('is too long (maximum is 6 characters)')
  end

  it 'is invalid with a duplicate email address' do
    User.create(
      nickname: 'Shinbo',
      email: 'test@we-b.co.jp',
      password: 'password'
    )
    user = User.new(
      email: 'test@we-b.co.jp'
    )
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end
end
