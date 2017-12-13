require 'rails_helper'

RSpec.describe Track, type: :model do
  context 'attribute validation' do
    it 'rejects nil name' do
      track = build(:track, name: nil)
      expect(track).to_not be_valid
      expect(track.errors[:name]).to_not be_empty
    end

    it 'rejects blank name' do
      track = build(:track, name: '')
      expect(track).to_not be_valid
      expect(track.errors[:name]).to_not be_empty
    end

    it 'rejects nil game parent' do
      track = build(:track, game: nil)
      expect(track).to_not be_valid
    end

    it 'rejects duplicate entry' do
      track = create(:track)
      expect(track).to be_valid

      dupe = build(:track, name: track.name, game: track.game)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end

    it 'rejects duplicate entry (case insensitive)' do
      track = create(:track, name: 'DOWNCASE ME')
      expect(track).to be_valid

      dupe = build(:track, name: track.name.downcase, game: track.game)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end
  end

  it 'can create valid track' do
    track = build(:track)
    expect(track).to be_valid
  end

  it 'destroys circuits when track is destroyed' do
    circuit = create(:circuit)
    expect(circuit).to be_valid

    circuit2 = create(:circuit, track: circuit.track)
    expect(circuit2).to be_valid

    expect{ circuit.track.destroy }.to change{ Circuit.count }.from(2).to(0)
  end
end
