require 'rails_helper'

describe 'games/game' do
  let(:game) { create(:Game) }
  let(:platforms) { [create(:Platform), create(:Platform)] }

  before(:example) do
    platforms.each do |p|
      create(:GamePlatformAssociation, game: game, platform: p)
    end
  end

  it 'renders full game information' do
    assign(:game, game)
    render partial: 'games/game', locals: { game: game }

    expect(rendered).to have_tag('li', with: { id: game.name.parameterize }) do
      with_tag 'a', with: { href: game_path(game) }
      with_tag 'span', text: game.developer
      with_tag 'span', text: game.publisher
      with_tag 'span', text: game.release.to_formatted_s(:long)
      with_tag 'span', text: game.platforms.map(&:name).join(' | ')
    end
  end
end
