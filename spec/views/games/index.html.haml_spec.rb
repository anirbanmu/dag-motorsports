require 'rails_helper'

RSpec.describe "games/index.html.haml", type: :view do
  let(:games) { [create(:Game), create(:Game), create(:Game)] }

  it 'displays games & details' do
    assign(:games, games)
    render
    expect(rendered).to render_template(partial: 'games/_game')
    games.each do |g|
      expect(rendered).to have_tag('li', with: { id: g.name.parameterize })
    end
  end
end
