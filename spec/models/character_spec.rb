require 'roda_helper'

RSpec.describe Character do
  let(:html) { Pathname.new(__FILE__).join('../../fixtures/simple.html').read }

  it 'returns the level' do
    char = Character.new(html)
    expect(char.level).to eq 45
  end

  it 'returns the item level' do
    char = Character.new(html)
    expect(char.item_level).to eq 44
  end
end
