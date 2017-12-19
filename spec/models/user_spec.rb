require 'rails_helper'

RSpec.describe User, type: :model do
  context 'attribute validation' do
    it 'rejects nil username' do
      user = build(:user, username: nil)
      expect(user).to_not be_valid
      expect(user.errors[:username]).to_not be_empty
    end

    it 'rejects blank username' do
      user = build(:user, username: '')
      expect(user).to_not be_valid
      expect(user.errors[:username]).to_not be_empty
    end

    it 'rejects duplicate username' do
      user = create(:user)
      dup_user = build(:user, username: user.username)
      expect(dup_user).to_not be_valid
      expect(dup_user.errors[:username]).to_not be_empty
    end

    it 'rejects duplicate username (case insensitive)' do
      user = create(:user, username: 'DoWnCaSeMe')
      dup_user = build(:user, username: user.username.downcase)
      expect(dup_user).to_not be_valid
      expect(dup_user.errors[:username]).to_not be_empty
    end

    it 'rejects nil email' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to_not be_empty
    end

    it 'rejects blank email' do
      user = build(:user, email: '')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to_not be_empty
    end

    it 'rejects duplicate email' do
      user = create(:user)
      dup_user = build(:user, email: user.email)
      expect(dup_user).to_not be_valid
      expect(dup_user.errors[:email]).to_not be_empty
    end

    it 'rejects duplicate email (case insensitive)' do
      user = create(:user, email: 'DoWnCaSeMe@CaSe.CoM')
      dup_user = build(:user, email: user.email.downcase)
      expect(dup_user).to_not be_valid
      expect(dup_user.errors[:email]).to_not be_empty
    end
  end

  it 'can create valid user' do
    user = build(:user)
    expect(user).to be_valid
  end
end
