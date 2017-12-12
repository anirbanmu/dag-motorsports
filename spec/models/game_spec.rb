require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'attribute validation' do
    it 'rejects nil name' do
      game = build(:Game, name: nil)
      expect(game).to_not be_valid
      expect(game.errors[:name]).to_not be_empty
    end

    it 'rejects duplicate name' do
      game = create(:Game)
      dupe = build(:Game, name: game.name.upcase)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end

    it 'rejects nil date' do
      game = build(:Game, release: nil)
      expect(game).to_not be_valid
      expect(game.errors[:release]).to_not be_empty
    end

    it 'rejects nil developer' do
      game = build(:Game, developer: nil)
      expect(game).to_not be_valid
      expect(game.errors[:developer]).to_not be_empty
    end

    it 'rejects blank developer' do
      game = build(:Game, developer: '')
      expect(game).to_not be_valid
      expect(game.errors[:developer]).to_not be_empty
    end

    it 'rejects nil publisher' do
      game = build(:Game, publisher: nil)
      expect(game).to_not be_valid
      expect(game.errors[:publisher]).to_not be_empty
    end

    it 'rejects blank publisher' do
      game = build(:Game, publisher: '')
      expect(game).to_not be_valid
      expect(game.errors[:publisher]).to_not be_empty
    end
  end

  it 'can create valid game' do
    game = build(:Game)
    expect(game).to be_valid
  end

  it 'destroys image when game is destroyed' do
    image = create(:Image)
    expect(image).to be_valid
    expect{ image.imageable.destroy }.to change{ Image.count }.from(1).to(0)
  end
end
