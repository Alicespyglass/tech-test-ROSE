require 'gilded_rose'
require_relative '../lib/item.rb'

describe GildedRose do
  let(:items) {
    # name, sell in, quality
    [
      # items[0]
      Item.new("widget", 10, 5),
      # items[1]
      Item.new("out-of-date", -1, 10),
      # items[2]
      Item.new("Aged Brie", 10, 5),
      # items[3]
      Item.new("Sulfuras, Hand of Ragnaros", 10, 5),
      # items[4]
      Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 5),
      # items[5]
      Item.new("Conjured", 10, 5),
      # items[6]
      Item.new("over-quality", 10, 60),
      # items[7]
      Item.new("zero-quality", 0, 0)
    ]}

  subject(:rose) { described_class.new(items) }


  context 'all items' do
    xit 'quality is never above 50' do
      rose.update_quality
      expect(rose.items[6].quality).to eq(50)
    end

    it 'quality is never negative' do
      rose.update_quality
      expect(rose.items[7].quality).to eq(0)
    end
  end

  context 'non-special items' do
    describe '#update_quality' do
      it 'automatically updates quality by -1' do
        expect{ rose.update_quality }.to change{ rose.items[0].quality }.by(-1)
      end

      it 'automatically updates sell_in by -1' do
        expect{ rose.update_quality }.to change{ rose.items[0].quality }.by(-1)
      end
    end

    describe 'sell by date' do
      it 'once passed, quality degrades twice as fast' do
        expect{ rose.update_quality }.to change{ rose.items[1].quality }.by(-2)
      end
    end
  end

  context 'special items' do
    describe 'Aged Brie' do
      it 'increases in quality the older it gets' do
        expect{ rose.update_quality }.to change{ rose.items[2].quality }.by(1)
      end
    end

    describe 'Backstage passes to a TAFKAL80ETC concert' do
      context '>10 days before sell_in date' do
        it 'increases in quality by 1' do
          expect{ rose.update_quality }.to change{ rose.items[4].quality }.by(1)
        end
      end

      context '10 > days > 5' do
        it 'increases in quality by 2' do
          rose.update_quality
          expect{ rose.update_quality }.to change{ rose.items[4].quality}.by(2)
        end
      end

      context '5 > days > 0' do
        it 'increases in quality by 3' do
          rose.items[4].sell_in = 3
          expect{ rose.update_quality }.to change{ rose.items[4].quality }.by(3)
        end
      end

      context 'after sell_in date' do
        it 'quality drops to 0' do
          12.times do
            rose.update_quality
          end
          expect(rose.items[4].quality).to eq(0)
        end
      end
    end

    describe 'Legendary item - Sulfuras' do
      it 'never has to be sold' do
        expect{ rose.update_quality }.to change{ rose.items[3].sell_in }.by(0)
      end

      it 'never decreases in Quality' do
        expect{ rose.update_quality }.to change{ rose.items[3].quality }.by(0)
      end
    end

    xdescribe 'Conjured items' do
      it 'degrade in Quality twice as a fast as normal items' do
        expect{ rose.update_quality }.to change{ rose.items[5].quality }.by(-2)
      end
    end
  end





end
