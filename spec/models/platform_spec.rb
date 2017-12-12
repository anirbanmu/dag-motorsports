require 'rails_helper'

RSpec.describe Platform, type: :model do
  context 'attribute validation' do
    it 'rejects nil name' do
      platform = build(:Platform, name: nil)
      expect(platform).to_not be_valid
      expect(platform.errors.messages[:name]).to_not be_empty
    end
  end

  it 'creates valid platform' do
    platform = build(:Platform)
    expect(platform).to be_valid
  end
end
