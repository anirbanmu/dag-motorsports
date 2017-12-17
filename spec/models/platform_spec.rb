require 'rails_helper'

RSpec.describe Platform, type: :model do
  context 'attribute validation' do
    it 'rejects nil name' do
      platform = build(:platform, name: nil)
      expect(platform).to_not be_valid
      expect(platform.errors.messages[:name]).to_not be_empty
    end

    it 'rejects duplicate' do
      platform = create(:platform)
      expect(platform).to be_valid

      dupe = build(:platform, name: platform.name)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end

    it 'rejects duplicate (case insensitive)' do
      platform = create(:platform, name: 'DOWNCASE ME')
      expect(platform).to be_valid

      dupe = build(:platform, name: platform.name.downcase)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end
  end

  it 'creates valid platform' do
    platform = build(:platform)
    expect(platform).to be_valid
  end
end
