require 'rails_helper'

RSpec.describe Car, type: :model do
  context 'attribute validation' do
    it 'rejects nil name' do
      car = build(:car, name: nil)
      expect(car).to_not be_valid
      expect(car.errors[:name]).to_not be_empty
    end

    it 'rejects blank name' do
      car = build(:car, name: '')
      expect(car).to_not be_valid
      expect(car.errors[:name]).to_not be_empty
    end

    it 'rejects nil game parent' do
      car = build(:car, game: nil)
      expect(car).to_not be_valid
    end

    it 'rejects duplicate entry' do
      car = create(:car)
      expect(car).to be_valid

      dupe = build(:car, name: car.name, game: car.game)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end

    it 'rejects duplicate entry (case insensitive)' do
      car = create(:car, name: 'DOWNCASE ME')
      expect(car).to be_valid

      dupe = build(:car, name: car.name.downcase, game: car.game)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end

    it 'accepts duplicate name but different game' do
      car = create(:car)
      expect(car).to be_valid

      dupe = build(:car, name: car.name)
      expect(dupe).to be_valid
    end

    it 'accepts duplicate name but different game (case insensitive)' do
      car = create(:car, name: 'DOWNCASE ME')
      expect(car).to be_valid

      dupe = build(:car, name: car.name.downcase)
      expect(dupe).to be_valid
    end
  end
end
