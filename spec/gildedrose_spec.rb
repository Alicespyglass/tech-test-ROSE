require 'gilded_rose'
require_relative '../lib/item.rb'

describe GildedRose do
  let(:items) {
    [ Item.new("widget", 10, 5),
      Item.new("bauble", 20, 10) ]
    }

  subject(:rose) { described_class.new(items) }

  context 'non-special item' do
    it 'quality updated' do
      # require 'pry'; binding.pry
      expect{ rose.update_quality }.to change{ rose.items[0].quality }.by(-1)
    end
  end


end
