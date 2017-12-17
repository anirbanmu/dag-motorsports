require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'attribute validation' do
    it 'rejects nil name' do
      game = build(:game, name: nil)
      expect(game).to_not be_valid
      expect(game.errors[:name]).to_not be_empty
    end

    it 'rejects duplicate name' do
      game = create(:game)
      dupe = build(:game, name: game.name)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end

    it 'rejects duplicate name (case insensitive)' do
      game = create(:game, name: 'DOWNCASE ME')
      dupe = build(:game, name: game.name.downcase)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end

    it 'rejects nil date' do
      game = build(:game, release: nil)
      expect(game).to_not be_valid
      expect(game.errors[:release]).to_not be_empty
    end

    it 'rejects nil developer' do
      game = build(:game, developer: nil)
      expect(game).to_not be_valid
      expect(game.errors[:developer]).to_not be_empty
    end

    it 'rejects blank developer' do
      game = build(:game, developer: '')
      expect(game).to_not be_valid
      expect(game.errors[:developer]).to_not be_empty
    end

    it 'rejects nil publisher' do
      game = build(:game, publisher: nil)
      expect(game).to_not be_valid
      expect(game.errors[:publisher]).to_not be_empty
    end

    it 'rejects blank publisher' do
      game = build(:game, publisher: '')
      expect(game).to_not be_valid
      expect(game.errors[:publisher]).to_not be_empty
    end
  end

  it 'can create valid game' do
    game = build(:game)
    expect(game).to be_valid
  end

  it 'destroys image when game is destroyed' do
    image = create(:image)
    expect(image).to be_valid
    expect{ image.imageable.destroy }.to change{ Image.count }.from(1).to(0)
  end

  it 'destroys tracks when game is destroyed' do
    track = create(:track)
    expect(track).to be_valid

    track2 = create(:track, game: track.game)
    expect(track2).to be_valid

    expect{ track.game.destroy }.to change{ Track.count }.from(2).to(0)
  end
end
