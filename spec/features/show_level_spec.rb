require 'roda_helper'

RSpec.describe 'The app', type: :feature do
  it 'shoes the level' do
    stub_request(:get, 'http://us.battle.net/wow/en/character/wyrmrest-accord/Skinnyghost/simple')
      .to_return(
        status: 200,
        body: Pathname.new(__FILE__).join('../../fixtures/simple.html').read
      )
    visit '/'

    expect(page).to have_content('45')
  end
end
