require 'rails_helper'

RSpec.describe Circuit, type: :model do
  context 'attribute validation' do
    it 'rejects nil name' do
      circuit = build(:circuit, name: nil)
      expect(circuit).to_not be_valid
      expect(circuit.errors[:name]).to_not be_empty
    end

    it 'rejects blank name' do
      circuit = build(:circuit, name: '')
      expect(circuit).to_not be_valid
      expect(circuit.errors[:name]).to_not be_empty
    end

    it 'accepts nil length' do
      circuit = build(:circuit, length: nil)
      expect(circuit).to be_valid
    end

    it 'rejects nil track parent' do
      circuit = build(:circuit, track: nil)
      expect(circuit).to_not be_valid
    end

    it 'rejects duplicate entry' do
      circuit = create(:circuit)
      expect(circuit).to be_valid

      dupe = build(:circuit, name: circuit.name, track: circuit.track)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end

    it 'rejects duplicate entry (case insensitive)' do
      circuit = create(:circuit, name: 'DOWNCASE ME')
      expect(circuit).to be_valid

      dupe = build(:circuit, name: circuit.name.downcase, track: circuit.track)
      expect(dupe).to_not be_valid
      expect(dupe.errors[:name]).to_not be_empty
    end
  end

  it 'can create a valid circuit' do
    circuit = build(:circuit)
    expect(circuit).to be_valid
  end
end
