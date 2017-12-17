require 'rails_helper'

describe 'tracks/track' do
  let(:track) { create(:track) }

  it 'renders circuit links' do
    3.times { create(:circuit, track: track) }
    expect(track.circuits.count).to be(3)

    render partial: 'tracks/track', locals: { track: track }

    track.circuits.each do |c|
      expect(rendered).to have_tag('p', with: { id: "#{track.name.parameterize}-circuits" } ) do
        with_tag 'a', with: { href: circuit_path(c) }
      end
    end
  end
end
