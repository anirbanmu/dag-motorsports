require 'rails_helper'

describe 'games/game' do
  let(:game) { create(:game) }
  let(:platforms) { [create(:platform), create(:platform)] }

  before(:example) do
    platforms.each do |p|
      create(:game_platform_association, game: game, platform: p)
    end
  end

  it 'renders full game information (no image)' do
    assign(:game, game)
    render partial: 'games/game', locals: { game: game }

    expect(rendered).to have_tag('li', with: { id: game.name.parameterize }) do
      with_tag 'a', with: { href: game_path(game) }
      with_tag 'span', text: game.developer
      with_tag 'span', text: game.publisher
      with_tag 'span', text: game.release.to_formatted_s(:long)
      with_tag 'span', text: game.platforms.map(&:name).join(' | ')
      without_tag 'img'
    end
  end

  it 'renders full game information (with image)' do
    image = create(:image, imageable: game)

    assign(:game, game)
    render partial: 'games/game', locals: { game: game }

    expect(rendered).to have_tag('li', with: { id: game.name.parameterize }) do
      with_tag 'a', with: { href: game_path(game) }
      with_tag 'span', text: game.developer
      with_tag 'span', text: game.publisher
      with_tag 'span', text: game.release.to_formatted_s(:long)
      with_tag 'span', text: game.platforms.map(&:name).join(' | ')
      with_tag 'img', with: { src: image.img_tag_src }
    end
  end
end
