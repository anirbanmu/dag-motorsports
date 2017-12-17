require 'rails_helper'

RSpec.describe Image, type: :model do
  let (:imageable_parent) { create(:game) }

  context 'attribute validation' do
    it 'rejects nil filename' do
      image = build(:image, filename: nil)
      expect(image).to_not be_valid
      expect(image.errors[:filename]).to_not be_empty
    end

    it 'rejects blank filename' do
      image = build(:image, filename: '')
      expect(image).to_not be_valid
      expect(image.errors[:filename]).to_not be_empty
    end

    it 'rejects nil mimetype' do
      image = build(:image, mimetype: nil)
      expect(image).to_not be_valid
      expect(image.errors[:mimetype]).to_not be_empty
    end

    it 'rejects blank mimetype' do
      image = build(:image, mimetype: '')
      expect(image).to_not be_valid
      expect(image.errors[:mimetype]).to_not be_empty
    end

    it 'rejects nil base64 representation' do
      image = build(:image, base64: nil)
      expect(image).to_not be_valid
      expect(image.errors[:base64]).to_not be_empty
    end

    it 'rejects blank base64 representation' do
      image = build(:image, base64: '')
      expect(image).to_not be_valid
      expect(image.errors[:base64]).to_not be_empty
    end

    it 'rejects nil parent' do
      image = build(:image, imageable: nil)
      expect(image).to_not be_valid
      expect(image.errors[:imageable]).to_not be_empty
    end
  end

  let(:placeholder_image) { Faker::Placeholdit.image }

  describe 'Image.properties_from_url with web URL' do
    it 'generates valid properties' do
      image = imageable_parent.create_image(Image.properties_from_url(placeholder_image))
      expect(image).to be_valid
    end
  end

  describe 'Image.properties_from_url with local file URL' do
    it 'generates valid properties' do
      image = imageable_parent.create_image(Image.properties_from_url(Rails.root.join('spec', 'fixtures', 'files', 'placeholder.png').to_s))
      expect(image).to be_valid
    end
  end

  it 'generates valid image' do
    image = build(:image)
    expect(image).to be_valid
  end
end
