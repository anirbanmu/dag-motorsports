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

    it 'rejects username with @ in it (preventing email collisions)' do
      user = build(:user, username: 'email@email.com')
      expect(user).to_not be_valid
      expect(user.errors[:username]).to_not be_empty
    end

    it 'rejects username with space in it' do
      user = build(:user, username: 'SP ACE')
      expect(user).to_not be_valid
      expect(user.errors[:username]).to_not be_empty
    end

    it 'accepts username with _ and .' do
      user = build(:user, username: 'user_name.')
      expect(user).to be_valid
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

  describe '.find_first_by_auth_conditions' do
    let(:user) { create(:user, username: 'MixedCaseUsername_.', email: 'EMAIL@email.net') }

    it 'finds by username' do
      found = User.find_first_by_auth_conditions(ActionController::Parameters.new(login: user.username))
      expect(found).to eq(user)
    end

    it 'finds by username (case insensitive)' do
      found = User.find_first_by_auth_conditions(ActionController::Parameters.new(login: user.username.downcase))
      expect(found).to eq(user)
    end

    it 'finds by email' do
      found = User.find_first_by_auth_conditions(ActionController::Parameters.new(login: user.email))
      expect(found).to eq(user)
    end

    it 'finds by email (case insensitive)' do
      found = User.find_first_by_auth_conditions(ActionController::Parameters.new(login: user.email.downcase))
      expect(found).to eq(user)
    end
  end

  it 'can create valid user' do
    user = build(:user)
    expect(user).to be_valid
  end
end
