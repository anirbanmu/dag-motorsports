require 'rails_helper'

RSpec.describe GamePlatformAssociation, type: :model do
  let(:platform) { create(:Platform) }
  let(:platform2) { create(:Platform) }
  let(:game) { create(:Game) }
  let(:game2) { create(:Game) }

  context 'attribute validation' do
    it 'rejects nil game' do
      assoc = build(:GamePlatformAssociation, game: nil)
      expect(assoc).to_not be_valid
      expect(assoc.errors[:game]).to_not be_empty
    end

    it 'rejects nil platform' do
      assoc = build(:GamePlatformAssociation, platform: nil)
      expect(assoc).to_not be_valid
      expect(assoc.errors[:platform]).to_not be_empty
    end

    it 'rejects duplicate' do
      assoc = create(:GamePlatformAssociation)
      expect(assoc).to be_valid

      dupe = build(:GamePlatformAssociation, game: assoc.game, platform: assoc.platform)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:platform_id]).to_not be_empty
    end
  end

  context 'valid attributes' do
    it 'no associations' do
      expect(platform.games).to be_empty
      expect(game.platforms).to be_empty
    end

    it 'associates one game to one platform' do
      assoc = create(:GamePlatformAssociation, game: game, platform: platform)
      expect(assoc).to be_valid
      expect(assoc.game).to eq(game)
      expect(assoc.platform).to eq(platform)

      expect(game.platforms.count).to eq(1)
      expect(game.platforms).to include(platform)

      expect(platform.games.count).to eq(1)
      expect(platform.games).to include(game)
    end

    it 'associates one game to many platforms' do
      assoc = create(:GamePlatformAssociation, game: game, platform: platform)
      expect(assoc).to be_valid
      expect(assoc.game).to eq(game)
      expect(assoc.platform).to eq(platform)

      assoc2 = create(:GamePlatformAssociation, game: game, platform: platform2)
      expect(assoc2).to be_valid
      expect(assoc2.game).to eq(game)
      expect(assoc2.platform).to eq(platform2)

      expect(game.platforms.count).to eq(2)
      expect(game.platforms).to include(platform)
      expect(game.platforms).to include(platform2)

      expect(platform.games.count).to eq(1)
      expect(platform.games).to include(game)

      expect(platform2.games.count).to eq(1)
      expect(platform2.games).to include(game)
    end

    it 'associates many games to one platform' do
      assoc = create(:GamePlatformAssociation, game: game, platform: platform)
      expect(assoc).to be_valid
      expect(assoc.game).to eq(game)
      expect(assoc.platform).to eq(platform)

      assoc2 = create(:GamePlatformAssociation, game: game2, platform: platform)
      expect(assoc2).to be_valid
      expect(assoc2.game).to eq(game2)
      expect(assoc2.platform).to eq(platform)

      expect(platform.games.count).to eq(2)
      expect(platform.games).to include(game)
      expect(platform.games).to include(game2)

      expect(game.platforms).to include(platform)
      expect(game.platforms.count).to eq(1)

      expect(game2.platforms).to include(platform)
      expect(game2.platforms.count).to eq(1)
    end
  end
end
