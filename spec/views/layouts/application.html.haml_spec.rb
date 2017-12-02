require 'rails_helper'

describe 'layouts/application' do
  let(:base_title) { ' | Dag Motorsports'}
  it 'has proper title' do
    page_title = 'my_test_title'
    view.provide(:title, page_title)
    render
    expect(rendered).to have_tag('title', text: page_title + base_title)
  end
end
