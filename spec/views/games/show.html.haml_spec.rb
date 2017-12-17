require 'rails_helper'

RSpec.describe "games/show.html.haml", type: :view do
  let(:game) { create(:game) }
  let(:tracks) { [create(:track, game: game), create(:track, game: game), create(:track, game: game)] }

  it 'renders each track' do
    3.times { create(:track, game: game) }
    assign(:game, game)
    render
    expect(rendered).to render_template(partial: 'games/_game_details')
    expect(rendered).to render_template(partial: 'tracks/_track')
    game.tracks.each do |t|
      expect(rendered).to have_tag('div', with: { id: t.name.parameterize })
    end
  end
end
