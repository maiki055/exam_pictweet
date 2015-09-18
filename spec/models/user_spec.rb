require 'rails_helper'

describe User, type: :model do
  it 'is invalid without a nickname'
  it 'is invalid without a email'
  it 'is invalid without a password'
  it 'is invalid when nickname length more than 6'
  it 'is invalid with a duplicate email address'
end